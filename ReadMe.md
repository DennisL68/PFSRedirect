# PSFRedirect

`PSFRedirect` redirects all Write-commands of PowerShell to use `Write-PSFMessage` of the module `PSFramework`. This is useful for instantly enabling light logging of legacy scripts that only uses `Write-Progress`, `Write-Host`, `Write-Verbose` etc. to show progress.

Instead of redirecting the stream of each Write-output cmdlet (where possible) to a log file by rewriting your code (or adding `Write-PSFMessage`), this module replaces the function of the standard write commands with proxy commands using the same name. The proxy command will log the output as well as performing the original command. There is no need to rewrite legacy code if you'd like to quickly start logging the output of any script or function already written.

This is also a good way to pin-point code where you actuually need to rewrite sections to enhance to log output.

## Requirements

This module requires `PSFramework` which is configured as a depedency within this module.

## How to use this repo

Install the module `PSFRedriect` from `PSGallery`.

As default, no redirection will be done to the builtin PowerShell cmdlets `Write-*`.  
Ta have your session use redirection, you'll need to first enable it with `Enable-PSFRedirect`.

To apply the redirections on all your PowerShell sessions, create an environment variable named `PSFRedirect` and set the value to `true` or `Enabled`.

If you makes this a machine environment variable and run `Enable-PSFRedirect` as an administrator, the redirection will be done on any PowerShell code through out the system that uses the PowerShell profile at initilization.

To set a log file deestionation besides the default used by PSFramework, create an environment variable named `PSFRemotePath` and configure it with a path of your own choosing, where you would like all log files to be created.

## References and links

* [MS Learn - PowerShell Write-cmdlets][1]
* [PSFramework - Getting Started with Logging][2]
* [Adam the Automator - PowerShell Logging Best Practices for IT Pros][3]
* [MS Scripting Guy - Understanding Streams, Redirection, and Write-Host in PowerShell][4]
* [GitHub - psframework][5]

[1]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-5.1#related-links
[2]: https://psframework.org/documentation/quickstart/psframework/logging.html
[3]: https://adamtheautomator.com/powershell-logging
[4]:https://devblogs.microsoft.com/scripting/understanding-streams-redirection-and-write-host-in-powershell/
[5]: https://github.com/PowershellFrameworkCollective/psframework