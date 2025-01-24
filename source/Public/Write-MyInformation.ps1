function Write-MyOutput {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position = 0)]
        [psobject]$MessageData,
        [Parameter(Position = 1)]
        [string[]]$Tag
    )

    begin {
        $Caller = (Get-PSCallStack)[1].Command
    }

    process {
        $LogMessage = "$MessageData"

        Microsoft.PowerShell.Utility\Write-Output @PSBoundParameters
        Write-PSFMessage -Level InternalComment -Message $LogMessage -Function $Caller -Tag $Tag
    }

<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Information
.ForwardHelpCategory Cmdlet

#>
}
