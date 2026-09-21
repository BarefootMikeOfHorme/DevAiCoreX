# DevAiCoreX CBOR Encoder (Raw Version)
# Encodes PowerShell objects into canonical CBOR (RFC 8949 style)

param(
    [Parameter(Mandatory = $true)]
    [string]$JsonInputPath,
    [Parameter(Mandatory = $true)]
    [string]$CborOutputPath
)

$rawJson = Get-Content $JsonInputPath -Raw
$data = $rawJson | ConvertFrom-Json

$stream = New-Object System.IO.MemoryStream
$writer = New-Object System.IO.BinaryWriter($stream, [System.Text.Encoding]::UTF8)

function Write-Cbor-MajorType {
    param(
        [int]$major,
        [ulong]$value
    )
    $initial = $major -shl 5
    if ($value -lt 24) {
        $writer.Write([byte]($initial + [byte]$value))
    } elseif ($value -lt 256) {
        $writer.Write([byte]($initial + 24))
        $writer.Write([byte]$value)
    } elseif ($value -lt 65536) {
        $writer.Write([byte]($initial + 25))
        $writer.Write([byte]([math]::Floor($value / 256)))
        $writer.Write([byte]($value % 256))
    } else {
        $writer.Write([byte]($initial + 26))
        $bytes = [BitConverter]::GetBytes([uint32]$value)
        if ([BitConverter]::IsLittleEndian) { [Array]::Reverse($bytes) }
        $writer.Write($bytes)
    }
}

function Write-Cbor-Unsigned {
    param([ulong]$value)
    Write-Cbor-MajorType -major 0 -value $value
}

function Write-Cbor-Negative {
    param([long]$value)
    $n = [ulong](-1 - $value)
    Write-Cbor-MajorType -major 1 -value $n
}

function Write-Cbor-ByteString {
    param([byte[]]$bytes)
    Write-Cbor-MajorType -major 2 -value $bytes.Length
    $writer.Write($bytes)
}

function Write-Cbor-TextString {
    param([string]$text)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    Write-Cbor-MajorType -major 3 -value $bytes.Length
    $writer.Write($bytes)
}

function Write-Cbor-Array {
    param([object[]]$items)
    Write-Cbor-MajorType -major 4 -value $items.Length
    foreach ($item in $items) {
        Write-Cbor-Value -value $item
    }
}

function Write-Cbor-Map {
    param([hashtable]$map)
    $keys = $map.Keys | Sort-Object { $_.ToString() }
    Write-Cbor-MajorType -major 5 -value $keys.Count
    foreach ($k in $keys) {
        Write-Cbor-TextString -text $k.ToString()
        Write-Cbor-Value -value $map[$k]
    }
}

function Write-Cbor-Simple {
    param([int]$simple)
    $writer.Write([byte]((7 -shl 5) + $simple))
}

function Write-Cbor-Value {
    param([object]$value)

    if ($null -eq $value) {
        Write-Cbor-Simple -simple 22
        return
    }

    $typeName = $value.GetType().Name

    switch ($typeName) {
        "Int32" {
            if ($value -ge 0) {
                Write-Cbor-Unsigned -value ([ulong]$value)
            } else {
                Write-Cbor-Negative -value ([long]$value)
            }
        }
        "Int64" {
            if ($value -ge 0) {
                Write-Cbor-Unsigned -value ([ulong]$value)
            } else {
                Write-Cbor-Negative -value ([long]$value)
            }
        }
        "Double" {
            $writer.Write([byte]((7 -shl 5) + 27))
            $bytes = [BitConverter]::GetBytes([double]$value)
            if ([BitConverter]::IsLittleEndian) { [Array]::Reverse($bytes) }
            $writer.Write($bytes)
        }
        "Boolean" {
            if ($value) {
                Write-Cbor-Simple -simple 21
            } else {
                Write-Cbor-Simple -simple 20
            }
        }
        "String" {
            Write-Cbor-TextString -text $value
        }
        "Object[]" {
            Write-Cbor-Array -items $value
        }
        "Hashtable" {
            Write-Cbor-Map -map $value
        }
        default {
            if ($value -is [System.Management.Automation.PSObject]) {
                $ht = @{}
                foreach ($p in $value.PSObject.Properties) {
                    $ht[$p.Name] = $p.Value
                }
                Write-Cbor-Map -map $ht
            } else {
                Write-Cbor-TextString -text ($value.ToString())
            }
        }
    }
}

Write-Cbor-Value -value $data
$writer.Flush()
$bytesOut = $stream.ToArray()
[System.IO.File]::WriteAllBytes($CborOutputPath, $bytesOut)

Write-Host "CBOR encoding complete: $CborOutputPath"
