function Write-MyWarning {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [String]$Message
    )
    $Caller = (Get-PSCallStack)[1].Command

    Write-PSFMessage -Level Warning -Message $Message -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Warning
.ForwardHelpCategory Cmdlet

#>

}# end function Write-MyWarning
