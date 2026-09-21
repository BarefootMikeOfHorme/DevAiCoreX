# DevAiCoreX CBOR Lineage Engine (Raw Version)
# Computes deterministic lineage hash from decoded CBOR

param(
    [Parameter(Mandatory = $true)]
    [string]$CborInputPath,
    [Parameter(Mandatory = $true)]
    [string]$LineageOutputPath
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

$json = $decoded | ConvertTo-Json -Depth 20
$bytesJson = [System.Text.Encoding]::UTF8.GetBytes($json)
$sha = [System.Security.Cryptography.SHA256]::Create()
$hashBytes = $sha.ComputeHash($bytesJson)
$hashHex = ($hashBytes | ForEach-Object { $_.ToString("x2") }) -join ""

$lineage = @{
    source = $CborInputPath
    hash = $hashHex
    timestamp = (Get-Date).ToString("o")
}

$linesOut = @(
    "// DevAiCoreX Lineage Record",
    "// Deterministic hash of decoded CBOR",
    "{",
    "  ""source"": ""$($lineage.source)"",",
    "  ""hash"": ""$($lineage.hash)"",",
    "  ""timestamp"": ""$($lineage.timestamp)""",
    "}"
)

Set-Content -Path $LineageOutputPath -Value ($linesOut -join "`n")

Write-Host "Lineage written to: $LineageOutputPath" -ForegroundColor Green
Write-Host "Hash: $hashHex"
