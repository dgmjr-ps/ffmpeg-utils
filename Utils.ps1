function Get-Dimensions([string]$In) {
    $dimensions = ffmpeg -i $In -f null - 2>&1 | Select-String -Pattern "Stream.*Video.*([0-9]+)x([0-9]+)"
    $dimensions = $dimensions -replace ".*([0-9]+)x([0-9]+).*", '$1,$2'
    $dimensions = $dimensions -split ","
    return $dimensions
}
