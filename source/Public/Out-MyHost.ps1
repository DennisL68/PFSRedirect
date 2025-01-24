function Out-MyHost {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [psobject[]]$InputObject,
        [switch]$Paging
    )

    begin {
        $Caller = (Get-PSCallStack)[1].Command

    }

    process {
        Microsoft.PowerShell.Core\Out-Host @PSBoundParameters

        $LogMessage = "OUT: $InputObject"

        Write-PSFMessage -Level InternalComment -Message $LogMessage -Function $Caller
    }

<#

.ForwardHelpTargetName Microsoft.PowerShell.Core\Out-Host
.ForwardHelpCategory Cmdlet

#>
}# end function
