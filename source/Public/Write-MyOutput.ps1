function Write-MyOutput {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [psobject[]]$InputObject,
        [switch]$NoEnumerate
    )

    begin {
        $Caller = (Get-PSCallStack)[1].Command
    }

    process {
        $LogMessage = "$InputObject"

        Microsoft.PowerShell.Utility\Write-Output @PSBoundParameters
        Write-PSFMessage -Level InternalComment -Message $LogMessage -Tag 'Write-Output' -Function $Caller
    }

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Output
.ForwardHelpCategory Cmdlet

#>
}
