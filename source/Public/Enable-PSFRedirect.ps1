﻿function Enable-PSFRedirect {
    if (-not $ENV:PSFREDIRECT)   { Update-EnvironmentVariable -VariableName PSFRedirect   }
    if (-not $ENV:PSFRemotePath) { Update-EnvironmentVariable -VariableName PSFRemotePath }

    if (-not (Get-Alias Write-Warning -ErrorAction SilentlyContinue)) {
        Microsoft.PowerShell.Utility\Write-Warning -Message 'All Write commands are being redirected to Write-PSFMessage'

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
    $Principal  = New-Object System.Security.Principal.WindowsPrincipal($CurrentUser)
    $IsAdmin    = $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

    $ThisProfile = $PROFILE
    
    if ($IsAdmin) {# use global pwsh profile
            $ThisProfile = $PROFILE.AllUsersAllHosts
    }


    if ($ThisProfile -and
        $ENV:PSFREDIRECT -in ('TRUE','ENABLED')) {# add module-import to profile
        
        if (-not (Test-Path $ThisProfile)) {# create profile file
            New-Item $ThisProfile -ItemType File -Force | Out-Null
        }
        
        if (-not (Select-String $ThisProfile -Pattern 'Enable-PSFRedirect')) {# if needed
            'Enable-PSFRedirect' | Out-File $ThisProfile -Append -Encoding utf8
        }
    }

    if ($ThisProfile -and
        $ENV:PSFREMOTEPATH) {# add start logging to profile

        Microsoft.PowerShell.Utility\Write-Warning -Message "All Write commands for process ($PID) are being logged to $($ENV:PSFRemotePath)"
        
        New-Item  $ENV:PSFRemotePath -ItemType Directory -ErrorAction SilentlyContinue
        if (-not (Test-Path $ENV:PSFRemotePath)) {
            Microsoft.PowerShell.Utility\Write-Warning -Message 'Issue with using folder in $ENV:PSFRemotePath variable.'
        }

        Start-PSFRemoteLogging -FolderPath $ENV:PSFRemotePath
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

    If you'd like to get a logfile of the output in an additional place besides the
    PSFRamework default, create the %PSFREMOTEPATH% environment variable and add
    the folder path where you want all your log files to e saved.

.EXAMPLE
    Enable-PSFRedirect

    Will active redirection for this sessesion.

.EXAMPLE
    [System.Environment]::SetEnvironmentVariable('PSFRedirect','True','Machine')
    Update-EnvironmentVariable -VariableName PSFRedirect

    Enable-PSFRedirect

    Will activate redirection for this session and configure your $PROFILE to always
    enable PSF redirect.

    If run as admin, the global $PROFILE will be set to pre-load PSFRedirect instead.

.EXAMPLE
    [System.Environment]::SetEnvironmentVariable('PSFRedirect','True','Machine')
    Update-EnvironmentVariable -VariableName PSFRedirect

    [System.Environment]::SetEnvironmentVariable('PSFRemotePath', '\\MySrv\MyShare\logfolder','Machine')
    Update-EnvironmentVariable -VariableName PSFRemotePath

    Enable-PSFRedirect

    Will add a logfile at \\MySrv\MyShare\logfolder

#>

}#end function Enable-PSFRedirect
