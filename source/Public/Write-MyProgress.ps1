function Write-MyProgress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$Activity,
        $Completed,
        [string]$CurrentOperation,
        [int]$Id,
        [int]$ParentId,
        [int]$PercentComplete,
        [int]$SecondsRemaining,
        [int]$SourceId,
        [string]$Status = 'Processing'
    )

    $Caller = (Get-PSCallStack)[1].Command

    Microsoft.PowerShell.Utility\Write-Progress @PSBoundParameters

    $LogMessage = "PROGRESS: $Activity - $Status"
    if ($PercentComplete) {
        $LogMessage = "PROGRESS: $Activity - $Status - $PercentComplete"
    }
    if ($SecondsRemaining) {
        $LogMessage = "PROGRESS: $Activity - $Status - $SecondsRemaining"
    }

    Write-PSFMessage -Level InternalComment -Message $LogMessage -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Progress
.ForwardHelpCategory Cmdlet

#>
}# end function Write-MyProgress
