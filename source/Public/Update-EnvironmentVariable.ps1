function Update-EnvironmentVariable {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$VariableName
    )

    $MachineValue   = [System.Environment]::GetEnvironmentVariable($VariableName, 'Machine')
    $UserValue      = [System.Environment]::GetEnvironmentVariable($VariableName, 'User')

    if ($MachineValue)  { $ThisValue = $MachineValue    }
    if ($UserValue)     { $ThisValue = $UserValue       } #User Overrides

    if ($ThisValue)     { Set-Item ENV:$VariableName -Value $ThisValue }

<#
.SYNOPSIS
    Updates content of an Environment variable

.DESCRIPTION
    Setting the machine or user envrionement variable within a PowerShell session
    won't update the $ENV used within that session (or even within a user session).

    This function iterates over both System and User environments and updates the
    $ENV:-value within the current session.

.EXAMPLE
    $ENV:MyVar = 'Initial Example'
    [System.Environment]::SetEnvironmentVariable('MyVar', 'System Example', 'Machine')

    Update-EnvironmentVariable -VariableName 'MyVar'

    Sets $ENV:MyVar to the value of the System variable for MyVar.

.EXAMPLE
    $ENV:MyVar = 'Initial Example'
    [System.Environment]::SetEnvironmentVariable('MyVar', 'User Example', 'User')
    [System.Environment]::SetEnvironmentVariable('MyVar', 'System Example', 'Machine')

    Update-EnvironmentVariable -VariableName 'MyVar'

    Sets $ENV:MyVar to the value of the User variable for MyVar.

#>

}
