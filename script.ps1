﻿<#
.SYNOPSIS
    A collection of useful scripts for lazy Microsoft 365 admins.
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
<#
Third-party modules used in this script:
    AnyBox - https://github.com/dm3ll3n/AnyBox/
    ExchangeOnlineManagement - https://www.powershellgallery.com/packages/ExchangeOnlineManagement
#>
#Banner als Base64 encodiert.
$banner = @"
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
"@
#Versionsnummer und Fenstertitel
$version = "0.0.1"
$mlasTitle = "m365-admin-scripts (v$version)"

<#
Exchange Online-Modul
#>
function Start-mslaEXO {
    Import-Module ExchangeOnlineManagement
    $answer = Show-AnyBox -Icon "Question" -Title $mlasTitle -Message 'Wie lautet der UPN Ihres globalen Microsoft 365 Administrator-Accounts?' -Prompt "" -Comment 'z.B. admin@contoso.com oder admin@contoso.onmicrosoft.com' -Buttons 'Anmelden'
    $upn = $answer.Input_0
    try{
        Connect-ExchangeOnline -UserPrincipalName $upn -ShowProgress $true
    }
    catch{
        $exoErrorAnswer = Show-AnyBox -Icon 'Error' -Title $mlasTitle -Message 'Bei der Herstellung der Remote-Verbindung zu Microsoft Exchange Online ist ein Fehler aufgetreten:',$_.Exception.Message  -Timeout 5 -Countdown -Buttons 'Beenden' -ContentAlignment Center
        $EXOError=$true
        Break
    }
    if($EXOError -eq $false -or (!$EXOError)){
        $mailboxDump = Get-EXOMailbox -ResultSize unlimited -PropertySets Minimum -Properties UserPrincipalName | foreach { $_.UserPrincipalName } | Sort-Object
        $continue=$true
        do{
            $prompts = @(New-Prompt -Name 'mailbox' -Message 'Welches Postfach soll verändert werden?' -ValidateSet $mailboxDump -ShowSeparator)
            $prompts += @(New-Prompt -Name 'language' -Message 'Welche Sprache soll verwendet werden?' -ValidateSet 'Deutsch', 'Englisch' -ShowSetAs 'Radio' -ShowSeparator)
            $promptAnswer = Show-AnyBox -Icon 'Question' -Title $mlasTitle -Prompt $prompts -Buttons 'Sprache des Postfachs ändern'
            $mailbox = $promptAnswer.mailbox
            switch($promptAnswer.language){
                'Englisch'{$language = "en-DE";$dateformat="dd/MM/yyyy";Break}
                default{$language = 'de-DE';$dateformat="dd.MM.yyyy";Break}
            }
            try{
                Set-MailboxRegionalConfiguration -Identity $mailbox -Language $language -TimeZone "W. Europe Standard Time" -DateFormat $dateformat -TimeFormat "HH:mm" -LocalizeDefaultFolderName
            }
            catch{
                $mailboxErrorAnswer = Show-AnyBox -Icon 'Error' -Title $mlasTitle -Message 'Bei der Verarbeitung der Spracheinstellungen ist ein Fehler aufgetreten:',$_.Exception.Message  -Timeout 5 -Countdown -Buttons 'Fortfahren' -ContentAlignment Center
                $MailboxError=$true
                Break
            }
            if($MailboxError -eq $false -or (!$MailboxError)){
                $successAnswer = Show-AnyBox -Icon 'Information' -Title $mlasTitle -Message 'Spracheinstellung des Postfachs erfolgreich bearbeitet' -Timeout 1 -Buttons 'Fortfahren' -ContentAlignment Center
            }
            $continueAnswer = Show-AnyBox -Icon 'Question' -Title $mlasTitle -Message 'Möchten Sie noch ein Postfach bearbeiten?' -Buttons 'Ja','Beenden' -MinWidth 300 -ContentAlignment Center
            if($continueAnswer.Beenden -eq $true){
                $continue = $false
                Break
            }
        }while($continue -eq $true)
    }
    Disconnect-ExchangeOnline -Confirm:$false
}
#Hauptmenü
do{
    $modules = 'Office 365','Exchange Online','Active Directory' | Sort-Object
    $prompt = @(New-Prompt -Name 'module' -Message 'Welches Modul soll geladen werden?' -ValidateSet $modules -DefaultValue 'Exchange Online')
    $answerModule = Show-AnyBox -WindowStyle ToolWindow -Image $banner -Title $mlasTitle -Prompt $prompt -Buttons 'Start','Beenden' -CancelButton 'Beenden' -DefaultButton 'Start' -Topmost:$true -MinWidth 400
    switch($answerModule.module){
        'Exchange Online'{Start-mslaEXO}
        'Office 365'{Show-AnyBox -Icon 'Error' -Title $mlasTitle -Message 'Modul zurzeit nicht verfügbar' -Buttons 'OK' -CancelButton 'OK' -DefaultButton 'OK' -ContentAlignment Center -WindowStyle None | Out-Null}
        'Active Directory'{Show-AnyBox -Icon 'Error' -Title $mlasTitle -Message 'Modul zurzeit nicht verfügbar' -Buttons 'OK' -CancelButton 'OK' -DefaultButton 'OK' -ContentAlignment Center -WindowStyle None | Out-Null}
    }
    if($answerModule.Beenden -eq $true){
        $close = $true
    }
}while($close -eq $false -or (!$close))
