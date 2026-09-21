# DevAiCoreX CBOR Inspector (Raw Version)
# Pretty-prints CBOR structure, major types, lengths, and values

param(
    [Parameter(Mandatory = $true)]
    [string]$CborInputPath
)

$bytes = [System.IO.File]::ReadAllBytes($CborInputPath)
$stream = New-Object System.IO.MemoryStream($bytes)
$reader = New-Object System.IO.BinaryReader($stream)

function Read-Cbor-Value {
    $offset = $stream.Position
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

    Write-Host ""
    Write-Host "Offset: $offset"
    Write-Host ("Initial Byte: 0x{0:X2}" -f $initial)
    Write-Host "Major Type: $major"
    Write-Host "Additional Info: $ai"

    switch ($major) {

        0 {
            $len = Read-Length $ai
            Write-Host "Unsigned Integer: $len"
            return $len
        }

        1 {
            $len = Read-Length $ai
            $val = -1 - $len
            Write-Host "Negative Integer: $val"
            return $val
        }

        2 {
            $len = Read-Length $ai
            Write-Host "Byte String Length: $len"
            $raw = $reader.ReadBytes($len)
            Write-Host ("Byte String (hex): " + ([BitConverter]::ToString($raw)))
            return $raw
        }

        3 {
            $len = Read-Length $ai
            Write-Host "Text String Length: $len"
            $raw = $reader.ReadBytes($len)
            $text = [System.Text.Encoding]::UTF8.GetString($raw)
            Write-Host "Text String: $text"
            return $text
        }

        4 {
            $len = Read-Length $ai
            Write-Host "Array Length: $len"
            $arr = @()
            for ($i = 0; $i -lt $len; $i++) {
                Write-Host "Array[$i]:"
                $arr += Read-Cbor-Value
            }
            return $arr
        }

        5 {
            $len = Read-Length $ai
            Write-Host "Map Length: $len"
            $map = @{}
            for ($i = 0; $i -lt $len; $i++) {
                Write-Host "Key:"
                $key = Read-Cbor-Value
                Write-Host "Value:"
                $val = Read-Cbor-Value
                $map[$key] = $val
            }
            return $map
        }

        7 {
            switch ($ai) {
                20 { Write-Host "Boolean: false"; return $false }
                21 { Write-Host "Boolean: true"; return $true }
                22 { Write-Host "Null"; return $null }
                27 {
                    $raw = $reader.ReadBytes(8)
                    if ([BitConverter]::IsLittleEndian) { [Array]::Reverse($raw) }
                    $val = [BitConverter]::ToDouble($raw, 0)
                    Write-Host "Float64: $val"
                    return $val
                }
                default { throw "Unsupported simple value" }
            }
        }

        default { throw "Unsupported CBOR major type: $major" }
    }
}

Write-Host "=== CBOR Inspector ==="
$decoded = Read-Cbor-Value
Write-Host ""
Write-Host "Decoded Structure:"
$decoded | Format-List
