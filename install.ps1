<#
.SYNOPSIS
    A script to install all required modules for m365-admin-script.
#>
function Check-Module{
    param (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   Position = 0)]
        [string]
        $Module
    )
    process{
        if (Get-Module -ListAvailable -Name $Module) {
            Write-Host "$Module already installed."
            
        }
        else {
            Write-Host "$Module was not found.`nInstalling $Module"
            Install-Module -Name $Module -Repository PSGallery
        }          
    }
}
Check-Module 'AnyBox'
Check-Module 'ExchangeOnlineManagement'