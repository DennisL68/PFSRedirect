function Write-MyEvenlog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$LogName,

        [Parameter(Mandatory, Position = 1)]
        [string]$Source,

        [Parameter(Mandatory, Position = 2)]
        [int]$EventId,

        [Parameter(Position = 3)]
        [EventEntryType]$EntryType,

        [Parameter(Mandatory, Position = 4)]
        [string]$Message,

        [int16]$Category,

        [byte[]]$Rawdata,

        [string]$ComputerName
    )

    $Caller = (Get-PSCallStack)[1].Command

    Microsoft.PowerShell.Utility\Write-Eventlog @PSBoundParameters

    $LogMessage = "$LogName - $Source : $EntryType : $Message"

    Write-PSFMessage -Level VeryVerbose -Message $LogMessage -Tag 'Write-EventLog', $Source -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Eventlog
.ForwardHelpCategory Cmdlet

#>
}# end function Write-MyProgress
