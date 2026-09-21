# DevAiCoreX CBOR Validator (Raw Version)
# Validates canonical CBOR ordering, structure, and basic schema fields

param(
    [Parameter(Mandatory = $true)]
    [string]$CborInputPath
)

$bytes = [System.IO.File]::ReadAllBytes($CborInputPath)
$stream = New-Object System.IO.MemoryStream($bytes)
$reader = New-Object System.IO.BinaryReader($stream)

function Read-Cbor-Value {
    $initial = $reader.ReadByte()
    $major = $initial -shr 5
    $ai = $initial -band 31

    function Read-Length {
        param([int]$ai)
        switch ($ai) {
            { $_ -lt 24 } { return $_ }
            24 { return $reader.ReadByte() }
            25 {
                $b1 = $reader.ReadByte()
                $b2 = $reader.ReadByte()
                return ($b1 * 256 + $b2)
            }
            26 {
                $raw = $reader.ReadBytes(4)
                if ([BitConverter]::IsLittleEndian) { [Array]::Reverse($raw) }
                return [BitConverter]::ToUInt32($raw, 0)
            }
            default { throw "Invalid CBOR length encoding" }
        }
    }

    switch ($major) {
        0 { return Read-Length $ai }
        1 { return (-1 - (Read-Length $ai)) }
        2 { $len = Read-Length $ai; return $reader.ReadBytes($len) }
        3 { $len = Read-Length $ai; $raw = $reader.ReadBytes($len); return [System.Text.Encoding]::UTF8.GetString($raw) }
        4 {
            $len = Read-Length $ai
            $arr = @()
            for ($i = 0; $i -lt $len; $i++) { $arr += Read-Cbor-Value }
            return $arr
        }
        5 {
            $len = Read-Length $ai
            $map = @{}
            for ($i = 0; $i -lt $len; $i++) {
                $key = Read-Cbor-Value
                $val = Read-Cbor-Value
                $map[$key] = $val
            }
            return $map
        }
        7 {
            switch ($ai) {
                20 { return $false }
                21 { return $true }
                22 { return $null }
                27 {
                    $raw = $reader.ReadBytes(8)
                    if ([BitConverter]::IsLittleEndian) { [Array]::Reverse($raw) }
                    return [BitConverter]::ToDouble($raw, 0)
                }
                default { throw "Invalid CBOR simple value" }
            }
        }
        default { throw "Invalid CBOR major type: $major" }
    }
}

try {
    $decoded = Read-Cbor-Value
    Write-Host "CBOR decoded successfully." -ForegroundColor Green
} catch {
    Write-Host "[FATAL] CBOR decode failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

function Validate-Canonical {
    param([object]$obj)

    if ($obj -is [hashtable]) {
        $keys = $obj.Keys
        $sorted = $keys | Sort-Object { $_.ToString() }

        if (-not ($keys -join "," -eq $sorted -join ",")) {
            Write-Host "[ERROR] Map keys are not in canonical order." -ForegroundColor Yellow
            return $false
        }

        foreach ($k in $keys) {
            if (-not (Validate-Canonical $obj[$k])) { return $false }
        }
    }

    if ($obj -is [System.Object[]]) {
        foreach ($item in $obj) {
            if (-not (Validate-Canonical $item)) { return $false }
        }
    }

    return $true
}

if (Validate-Canonical $decoded) {
    Write-Host "Canonical ordering OK." -ForegroundColor Green
} else {
    Write-Host "[WARN] Canonical ordering failed." -ForegroundColor Yellow
}

function Validate-Schema {
    param([hashtable]$map)

    $required = @("version", "updated", "parentPath")

    foreach ($r in $required) {
        if (-not $map.ContainsKey($r)) {
            Write-Host "[ERROR] Missing required field: $r" -ForegroundColor Red
            return $false
        }
    }

    Write-Host "Basic schema fields OK." -ForegroundColor Green
    return $true
}

if ($decoded -is [hashtable]) {
    Validate-Schema $decoded | Out-Null
} else {
    Write-Host "[WARN] Root CBOR is not a map; skipping schema validation." -ForegroundColor Yellow
}

Write-Host "CBOR validation complete."
