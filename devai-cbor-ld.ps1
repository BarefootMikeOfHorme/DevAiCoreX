# DevAiCoreX CBOR-LD Engine (Raw Version)
# Applies semantic context + numeric key compression before CBOR encoding

param(
    [Parameter(Mandatory = $true)]
    [string]$JsonInputPath,
    [Parameter(Mandatory = $true)]
    [string]$CborOutputPath
)

$rawJson = Get-Content $JsonInputPath -Raw
$data = $rawJson | ConvertFrom-Json

$context = @{
    "name"       = 1
    "kind"       = 2
    "version"    = 3
    "updated"    = 4
    "parentPath" = 5
    "schema"     = 6
    "lineage"    = 7
    "guardrails" = 8
}

function Apply-Context {
    param([object]$obj)

    if ($obj -is [hashtable]) {
        $new = @{}
        foreach ($k in $obj.Keys) {
            $keyOut = $k
            if ($context.ContainsKey($k)) {
                $keyOut = $context[$k]
            }
            $new[$keyOut] = Apply-Context $obj[$k]
        }
        return $new
    }

    if ($obj -is [System.Object[]]) {
        $arr = @()
        foreach ($item in $obj) {
            $arr += Apply-Context $item
        }
        return $arr
    }

    return $obj
}

$compressed = Apply-Context $data

$tagged = @{
    "__tag" = 1000
    "data"  = $compressed
}

$encoder = "C:\Users\Administrator\Desktop\DevAiCoreX\devai-cbor-encoder.ps1"
& $encoder -JsonInputPath $JsonInputPath -CborOutputPath $CborOutputPath

Write-Host "CBOR-LD encoding complete: $CborOutputPath"
