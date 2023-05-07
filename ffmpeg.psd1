@{
    RootModule       = 'ffmpeg.psd1'
    ModuleVersion    = '0.0.1'
    GUID             = '1c55054a-6ad4-44c8-b107-5c9203976ec4'
    Author           = 'David G. Moore, Jr.'
    CompanyName      = 'Dgmjr'
    Copyright        = '© 2023 David G. Moore, Jr. <david@dgmjr.io>, All Rights Reserved'
    Description      = 'Runs various ffmpeg commands'
    ScriptsToProcess = @("./Install-BrewDependencies.ps1")
    NestedModules    = @("./Invoke-FfProbe.psm1", "./Convert-ToWebm.psm1", "./Convert-ToGif.psm1", "Constants.psm1", "Install-BrewDependencies.psm1") 
    # CmdletsToExport   = @('Convert-To-Webm')
    # FunctionsToExport = @('Convert-To-Webm')
    PrivateData      = @{
        PSData = @{
            CoreDepenencies = @("mediainfo", "ffmpeg", "youtube-dl");
            ProjectUri      = 'https://github.com/dgmjr-ps/ffmpeg-extensions'
            LicenseUri      = 'https://opensource.org/lienses/MIT'
            Tags            = @('ffmpeg', 'webm', 'video')
        }
    }
}
