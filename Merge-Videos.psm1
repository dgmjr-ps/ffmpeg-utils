function Merge-Videos {
    [Alias("merge")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("i")]
        [string[]]$In,
        [Parameter()]
        [Alias("o")]
        [string]$Out
    )
    begin {
        Write-Verbose("Begining concatenation of " + [String]::Join(",", $In) + "...")
    }
    process {
        ffmpeg "`"" + [String]::Join(" ", $In) + "`"" "`"" + $Out "`""
    }
    end {
        Write-Verbose("Written to new file:" + $Out)
    }
}

Export-ModuleMember -Function Merge-Videos
