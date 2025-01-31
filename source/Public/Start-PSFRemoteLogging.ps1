function Start-PSFRemoteLogging {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$FolderPath
    )

    if (-not (Get-Module PSFramework)) {
        throw 'Module PSFramework missing'
    }
    

    $param = @{
        Name        = 'logfile'
        InstanceName = 'Remote'
        FilePath    = "$FolderPath/PSF_%ComputerName%_%ProcessId%.log"
        FileType    = 'CSV'
        Enabled     = $true
        Wait        = $true
    }
    Set-PSFLoggingProvider @param
<# ! Doesn't wait for LoggingProvider
    if (-not (Test-Path "$FolderPath\PSF_%ComputerName%_%ProcessId%.log")) {
        throw "Failed to create PSFramework log file at remote $FolderPath"
    }
 #>
<#
.SYNOPSIS
    Defines a log file for PSFramework to use at a remote location.

.DESCRIPTION
    Defines the logfile LoggingProvider of PSFRamework when an instance named Remote
    with a filepath using the name PSF_%ComputerName%_%ProcessId%.log

    By always using PFS_*.log you can easaly set up file specific parsing rules in 
    your favorite log viewer tool.

.NOTES
    The account starting the PowerShell session needs write permission at the share.

    PSFramework do support setting up persistent log file definitions, but I didn't had
    the time to figure at a working syntax.

.EXAMPLE
    Start-PSFRemoteLoging -FolderPath \\srv1\logshare\logfolder
    
#>

}
