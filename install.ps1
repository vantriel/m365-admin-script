<#
.SYNOPSIS
    A script to install all required modules for m365-admin-scripts.
.AUTHOR
    Julian van Triel (julian[at]vantriel.email)
    github.com/vantriel
.LICENSE
    MIT License

    Copyright (c) 2020 Julian van Triel

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
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