function Write-MyVerbose {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$Message
    )
    $Caller = (Get-PSCallStack)[1].Command

    Write-PSFMessage -Level Verbose -Message $Message -Function $Caller

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Verbose
.ForwardHelpCategory Cmdlet

#>

}# end function
