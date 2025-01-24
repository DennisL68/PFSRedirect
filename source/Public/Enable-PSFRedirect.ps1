function Enable-PSFRedirect {
    if (-not (Get-Alias Write-Warning -ErrorAction SilentlyContinue)) {
        Write-Warning -Message 'All Write commands are being redirected to Write-PSFMessage'

        Set-Alias Write-Information -Value Write-MyInformation  -Scope Global
        Set-Alias Write-Verbose     -Value Write-MyVerbose      -Scope Global
        Set-Alias Write-Debug       -Value Write-MyDebug        -Scope Global
        Set-Alias Write-Warning     -Value Write-MyWarning      -Scope Global
        Set-Alias Write-Error       -Value Write-MyError        -Scope Global
        Set-Alias Write-Host        -Value Write-MyHost         -Scope Global
        Set-Alias Write-Output      -Value Write-MyOutput       -Scope Global
        Set-Alias Write-Progress    -Value Write-MyProgress     -Scope Global
        Set-Alias Write-Eventlog    -Value Write-MyEventlog     -Scope Global
        Set-Alias Out-Host          -Value Out-MyHost           -Scope Global

    }# end if module exists

    $CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object System.Security.Principal.WindowsPrincipal($CurrentUser)
    $IsAdmin = $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

    $MyProfile = $PROFILE
    $MachinePSFRedirect = [System.Environment]::GetEnvironmentVariable('PSFRedirect', 'Machine')

    if ($IsAdmin -and
        $MachinePSFRedirect -in ('TRUE','ENABLED') ) {# use global pwsh profile
        $MyProfile = $PROFILE.AllUsersAllHosts
    }

    if (-not (Test-Path $MyProfile)) {# create profile file
        New-Item $MyProfile -ItemType File -Force
    }

    if ($MyProfile -and
        $ENV:PSFREDIRECT -in ('TRUE','ENABLED')) {# add module-import to profile
        if (-not (Select-String $Profile -Pattern 'Import-Module PSFRedirect')) {# if needed
            'Import-Module PSFRedirect' | Out-File $MyProfile -Append -Encoding utf8
        }
    }

<#
.SYNOPSIS
    Enables redirection of all Write-commands of PowerShell to use Write-PSFMessage.

.DESCRIPTION
    Enables redirecting all Write-commands of PowerShell to use Write-PSFMessage of the
    module PSFramework such as Write-Verbose, Write-Host, Write-Output etc.

.NOTES
    To configure your environment to always redirect Write-messages to Write-PSFMessage,
    set the machine environment variable %PFSREDIRECT% to 'TRUE' or 'ENABLED'.

    Running this as admin will enable redirection for all PowerShell user profiles.

.EXAMPLE
    Enable-PSFRedirect

    Write-Warning 'Hello world'
    WARNING: [20:31:05][<ScriptBlock>] Hello world

    Get-PSFMessage

    Timestamp            FunctionName    Line Level           TargetObject Message
    ---------            ------------    ---- -----           ------------ -------
    2025-01-22 20:31:05  <ScriptBlock>   50   Warning                      Hello world

.EXAMPLE
    $ENV:PSFREDIRECT = 'TRUE'

    Import-Module PFSRedirect -Force

    Write-Warning 'Hello world'
    WARNING: [20:37:17][<ScriptBlock>] Hello world

    Get-PSFMessage

    Timestamp            FunctionName    Line Level           TargetObject Message
    ---------            ------------    ---- -----           ------------ -------
    2025-01-22 20:37:17  <ScriptBlock>   50   Warning                      Hello world

#>

}#end function Enable-PSFRedirect

if ($ENV:PSFREDIRECT -in ('TRUE','ENABLED')) {
    Enable-PSFRedirect
}
