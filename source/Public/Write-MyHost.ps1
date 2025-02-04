function Write-MyHost {
    [CmdletBinding()]
    param (
        [ConsoleColor]$BackgroundColor,
        [ConsoleColor]$ForeGroundColor,
        [switch]$NoNewline,
        [Parameter(Position = 0)]
        $Object,
        $Separator
    )

    $Caller = (Get-PSCallStack)[1].Command

    Microsoft.PowerShell.Utility\Write-Host @PSBoundParameters

    $LogMessage = "$Object"

    Write-PSFMessage -Level InternalComment -Message $LogMessage -Tag 'Write-Host' -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Host
.ForwardHelpCategory Cmdlet

#>
}# end function Write-MyHost
