function Write-MyError {
    [CmdletBinding(DefaultParameterSetName = 'Message')]
    param (
        [Parameter(ParameterSetName = 'Message')]
        [System.Management.Automation.ErrorCategory]$Category,

        [string]$CategoryActivity,

        [string]$CategoryReason,

        [string]$CategoryTargetName,

        [string]$CategoryTargetType,

        [Parameter(ParameterSetName = 'Message')]
        [Parameter(ParameterSetName = 'Exception')]
        [string]$ErrorId,

        [Parameter(ParameterSetName = 'ErrorRecord', Mandatory)]
        [System.Management.Automation.ErrorRecord]$ErrorRecord,

        [Parameter(ParameterSetName = 'Exception', Mandatory)]
        [Exception]$Exception,

        [Parameter(ParameterSetName = 'Exception')]
        [Parameter(ParameterSetName = 'Message')]
        [string]$Message,

        [string]$RecommendedAction,

        [Parameter(ParameterSetName = 'Exception')]
        [Parameter(ParameterSetName = 'Message')]
        [Object]$TargetObject
    )
    $Caller = (Get-PSCallStack)[1].Command

    Microsoft.PowerShell.Utility\Write-Error @PSBoundParameters

    $LogMessage = "ERROR: $ErrorRecord - $Exeption"
    if ($Message) {
        $LogMessage = "ERROR: $ErrorRecord - $Exeption - $Message"
    }

    Write-PSFMessage -Level Error -Message $LogMessage -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Error
.ForwardHelpCategory Cmdlet

#>
}#end function Write-MyError
