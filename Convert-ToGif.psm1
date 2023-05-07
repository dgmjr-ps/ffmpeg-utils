function Convert-ToGif {
    [CmdletBinding()]
    [Alias("2gif", "gif")]
    param(
        # The environment to initialize the repo for. Defaults to "Local".
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The file to convert to a GIF")]
        [string]$In,
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The name of the GIF file to create")]
        [string]$Out,
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The maximum dimension of the generated GIF (in either direction)")]
        [Alias("maxdim", "max")]
        [string]$MaxDiension = 512
    )

    begin {
        if (-not [System.String]::IsNullOrEmpty(($Out))) {
            if (-not $Out.EndsWith(".gif")) {
                $Out = "$Out.gif"
            }
        } else {
            $Out = ("$PSScriptRoot/$In") -replace "\.[^.]+$", ".gif"
            if (-not $Out.EndsWith(".gif")) {
                $Out = "$Out.gif"
            }
        }
        Write-Output "Convering $In to $Out"

        $AspectRatio = Get-AspectRatio $In

        $Width = Get-Width $In
        $Height = Get-Height $In

        if ($Width -gt $Height) {
            $Width = ($Width * $AspectRatio);
            $Height = ($Height / $AspectRatio);
        } else {
            $Width = $Width / $AspectRatio
            $Height = $Height * $AspectRatio
        }
    }
    process {
        ffmpeg -i $In -fps 10 -complex-filter "flags=lanczos,split [o1] [o2];[o1] palettegen [p]; [o2] fifo [o3];[o3] [p] paletteuse" -vf scale=@ { $Width, $Height } $Out
    }

    end {
        Write-Output "Converted $In to $Out"
    }
}

Export-ModuleMember -Function Convert-ToGif
Export-ModuleMember -Alias 2gif gif
