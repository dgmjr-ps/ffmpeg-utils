function Install-Dependencies {
    [CmdletBinding()]
    [Alias("installdependencies")]
    param ([string[]]$Dependencies)

    begin {
        $brewList = "brew list"
        $brewInstall = "brew install"
        $dependencies = ($null -eq $Dependencies -or $Dependencies.Length -eq 0) ? $CoreDepenencies : $Dependencies
    }
    process {
        foreach ($dependency in $Dependencies) {
            $brewListCommand = "$brewList $dependency"
            $brewListCommand | Invoke-Expression
            if ($LastExitCode -ne 0) {
                $brewInstallCommand = "$brewInstall $dependency"
                $brewInstallCommand | Invoke-Expression
            }
        }
    }
    end {
        Write-Output "Installed or verified dependencies: $Dependencies"
    }
}

Install-BrewDependencies $CoreDepenencies;
