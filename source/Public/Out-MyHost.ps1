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

        Write-PSFMessage -Level InternalComment -Message $InputObject -Tag 'Out-Host' -Function $Caller
    }

<#

.ForwardHelpTargetName Microsoft.PowerShell.Core\Out-Host
.ForwardHelpCategory Cmdlet

#>
}# end function
