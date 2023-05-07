function Invoke-FfProbe { 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File,
    
        [Parameter(Mandatory = $true)]
        [Alias("entries")]
        [string]$Args
    )

    begin {
        $cmd = "ffprobe -i $File -v error -select_streams v -show_entries $Args -of csv=p=0:s=x"
        $response = Invoke-Expression $cmd 
    } 
    end {
        return $response
    }
}

function Get-Dimensions {
    [Alias("getdims", "getdimensions", "dimensions", "dims")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File
    )
    $dimensions = Invoke-FfProbe -File $File -Args "stream=width, height"
    $dimensions = $dimensions -split "x"
    return $dimensions
}
function Get-Width {
    [Alias("getwidth", "width")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File
    )
    $ ffmpeg -i $File4 2>&1 | grep Video: | grep -Po '\d{3,5}x\d{3,5}' | cut -d'x' -f2

}
function Get-Height {
    [Alias("getheight", "height")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File
    )
    $ ffmpeg -i $File 2>&1 | grep Video: | grep -Po '\d{3,5}x\d{3,5}' | cut -d'x' -f1
}

function Get-AspectRatio {
    [Alias("getaspectratio", "aspectratio", "aspect", "ar")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File
    )
    $dimensions = Get-Dimensions -In $File
    $width = $dimensions[0]
    $height = $dimensions[1]
    $aspectRatio = $width / $height
    return $aspectRatio
}

function Get-VideoDuration {
    [Alias("getvideoduration", "videoduration", "duration", "dur")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File
    )
    $duration = Invoke-FfProbe -File $File -Args "format=duration"
    return $duration
}
function Get-VideSize {
    [Alias("getvideosize", "videosize", "size", "sz")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("In")]
        [string]$File
    )
    $size = Invoke-FfProbe -File $File -Args "format=size"
    return $size
}


Export-ModuleMember -Function Invoke-FfProbe
Export-ModuleMember -Function Get-Dimensions
Export-ModuleMember -Function Get-Width
Export-ModuleMember -Function Get-Height
Export-ModuleMember -Function Get-AspectRatio
Export-ModuleMember -Function Get-VideoDuration
Export-ModuleMember -Function Get-VideSize
