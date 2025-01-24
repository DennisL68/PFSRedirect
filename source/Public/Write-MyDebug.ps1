function Write-MyDebug {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [String]$Message
    )
    $Caller = (Get-PSCallStack)[1].Command

    Write-PSFMessage -Level Debug -Message $Message -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Debug
.ForwardHelpCategory Cmdlet

#>

}# end function Write-MyDebug
