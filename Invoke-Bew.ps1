

function Merge-Videos {
    [CmdletBinding()]
    [Alias("concat")]
    param(
        # The environment to initialize the repo for. Defaults to "Local".
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The file to convert to webm")]
        [Alias("in")]
        [string[]]$In,
        [Alias("out")]
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The name of the webm file to create")]
        [string]$Out
    )

    begin {

        $Out = [System.String]::IsNullOrEmpty($Out) ? "output.mp4" : $Out;

        $In = $In -join "|"
    
        $cmd = "ffmpeg -i ""concat:$In"" -c copy $Out"
        
        Execute-Command $Cmd
    }
    
    process {
        Write-Debug "Converting $In to $Out"
        ffmpeg -i $In -c:yp9 -pix_fmt yuv420p $Out
    }

    end {
        Write-Output "Converted $In to $Out"
    }
}
