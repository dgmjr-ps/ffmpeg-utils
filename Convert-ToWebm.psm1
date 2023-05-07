

function Convert-ToWebm {
    [CmdletBinding()]
    [Alias("2webm", "webm")]
    param(
        # The environment to initialize the repo for. Defaults to "Local".
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The file to convert to webm")]
        [string]$In,
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The name of the webm file to create")]
        [string]$Out
    )

    begin {
        if (-not [System.String]::IsNullOrEmpty(($Out))) {
            $Out = (Join-Path -Path "$PSScriptRoot" -ChildPath "$Out")
        }
        else {
            $Out = ("$PSScriptRoot/$In") -replace "\.[^.]+$", ".webm"
            if (-not($Out -like '*.webm')) {
                $Out = "$Out.webm"
            }
        }
        Write-Output "Converting $In to $Out"
    }

    process {
        $videoBitrate = 1000000;
        $videoSize = 10000000;
        # ffmpeg -i $In -c:v libvpx-vp9 -b:v 0 -crf 30 -vf "scale=min'(512,iw)':-2" -fs 256k -t 3 $Out
        do {
            Copy-Item -Path $In -Destination $Out -Force

            $videoWidth = (Get-Width -In $Out);
            $videoHeight = (Get-Height -In $Out);
            $videoLength = (Get-VideoDuration -In $Out);

            Write-Output "Video width is $videoWidth and video height is $videoHeight and the video length is $videoLength"

            if ($videoWidth -gt $WebmMaxDimension) {
                $videoHeight = [Math]::Round(($videoHeight / $videoWidth) * $WebmMaxDimension);
                $videoWidth = $WebmMaxDimension;
            }
            else {
                $videoWidth = [Math]::Round(($videoWidth / $videoHeight) * $WebmMaxDimension);
                $videoHeight = $WebmMaxDimension;
            }

            ffmpeg -i $In - -c:v libvpx -crf 10 -b:v $videoBitrate -c:a libvorbis -vf scale= -t 3 $Out
            if ((Get-Item -Path $Out).Exists) {
                $videoSize = (Get-Item -Path $Out).Length;
                if ($videoSize -gt $WemMaxSize) {
                    $videoBitrate = $videoBitrate - 10000;
                    Write-Output "Video size is $videoSize, which is too large. Reducing bitrate to $videoBitrate"
                }
                else {
                    Write-Output "Video size is $videoSize, which is small enough. Stopping."
                    break;
                }
                Remove-Item -Path $Out -Force
            }
            $videoBitrate = $videoBitrate - 10000;
        } while ($videoSize -gt $WemMaxSize);
        #ffmpeg -i $In -c:v libvpx-vp9 -crf 15 -b:v 0 -fs 256k -c:a libvorbis $Out
    }

    end {
        Write-Output "Converted $In to $Out"
    }
}


Export-ModuleMember -Function Convert-ToWebm
