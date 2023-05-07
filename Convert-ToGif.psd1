@{
    RootModule       = 'ffmpeg.psd1'
    ModuleVersion    = '0.0.1'
    GUID             = 'b23d9299-1668-4722-9fce-703f48ab8ade'
    Author           = 'David G. Moore, Jr.'
    CompanyName      = 'DGMJR'
    Copyright        = '© 2023 David G. Moore, Jr. <david@dgmjr.io>, All Rights Reserved'
    Description      = 'Converts a vdeo file to a GIF'
    ScriptsToProcess = @("./Install-BrewDependencies.ps1")
    NestedModules    = @("./Invoke-FfProbe.psm1", "./Convert-ToWebm.psm1", "./Convert-ToGif.psm1", "Constants.psm1", "Install-BrewDependencies.psm1") 
    # CmdletsToExport   = @('Convert-To-Webm')
    # FunctionsToExport = @('Convert-To-Webm')
    PrivateData      = @{
        PSData = @{
            ProjectUri = 'https://github.com/dgmjr-ps/ffmpeg-extensions'
            LicenseUri = 'https://opensource.org/lienses/MIT'
            Tags       = @('ffmpeg', 'webm', 'video')
        }
    }
}
