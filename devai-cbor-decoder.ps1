# DevAiCoreX CBOR Decoder (Raw Version)
# Decodes canonical CBOR into PowerShell objects

param(
    [Parameter(Mandatory = $true)]
    [string]$CborInputPath,
    [Parameter(Mandatory = $true)]
    [string]$JsonOutputPath
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
            default { throw "Unsupported length encoding" }
        }
    }

    switch ($major) {

        0 {
            $len = Read-Length $ai
            return $len
        }

        1 {
            $len = Read-Length $ai
            return -1 - $len
        }

        2 {
            $len = Read-Length $ai
            $raw = $reader.ReadBytes($len)
            return $raw
        }

        3 {
            $len = Read-Length $ai
            $raw = $reader.ReadBytes($len)
            return [System.Text.Encoding]::UTF8.GetString($raw)
        }

        4 {
            $len = Read-Length $ai
            $arr = @()
            for ($i = 0; $i -lt $len; $i++) {
                $arr += Read-Cbor-Value
            }
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
                default { throw "Unsupported simple value" }
            }
        }

        default { throw "Unsupported CBOR major type: $major" }
    }
}

$decoded = Read-Cbor-Value
$json = $decoded | ConvertTo-Json -Depth 20
Set-Content -Path $JsonOutputPath -Value $json

Write-Host "CBOR decoding complete: $JsonOutputPath"
