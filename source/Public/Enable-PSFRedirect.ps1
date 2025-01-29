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

    $ThisProfile = $PROFILE
    $MachinePSFRedirect = [System.Environment]::GetEnvironmentVariable('PSFRedirect', 'Machine')

    if ($IsAdmin -and
        $MachinePSFRedirect -in ('TRUE','ENABLED') ) {# use global pwsh profile
        $ThisProfile = $PROFILE.AllUsersAllHosts
    }

    if (-not (Test-Path $ThisProfile)) {# create profile file
        New-Item $ThisProfile -ItemType File -Force
    }

    if ($ThisProfile -and
        $ENV:PSFREDIRECT -in ('TRUE','ENABLED')) {# add module-import to profile
        if (-not (Select-String $ThisProfile -Pattern 'Import-Module PSFRedirect')) {# if needed
            'Import-Module PSFRedirect' | Out-File $ThisProfile -Append -Encoding utf8
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
    set the machine environment variable %PSFREDIRECT% to 'TRUE' or 'ENABLED'.

    Running this as admin will enable redirection for all PowerShell user profiles.

.EXAMPLE
    Enable-PSFRedirect

    Will active redirection for this sessesion.

.EXAMPLE
    $ENV:PSFREDIRECT = 'TRUE'

    Import-Module PSFRedirect -Force

    Will activate redirection for this session and configure your $PROFILE to always
    pre-load the PSFRedirect module.

.EXAMPLE
    [System.Environment]::SetEnvironmentVariable('PSFRedirect','True','Machine')
    Start-Process PowerShell.exe -NoNewWindow -Wait

    Enable-PSFRedirect

    Will activate redirection for the new session and configure your $PROFILE to always
    pre-load the PSFRedirect module.

    If run as admin, the global $PROFILE will be set to pre-load PSFRedirect instead.

#>

}#end function Enable-PSFRedirect

if ($ENV:PSFREDIRECT -in ('TRUE','ENABLED')) {
    Enable-PSFRedirect
}
