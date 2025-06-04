$ErrorActionPreference = "Stop"

Install-Module -Name Pester -MinimumVersion "5.6.1" -Force
Import-Module -Name Pester -MinimumVersion "5.6.1"

Install-Module PSPostgres
Import-Module PSPostgres

$cfg = New-PesterConfiguration

# $cfg.Output.Verbosity           = "Detailed"
$cfg.Output.Verbosity           = "Normal"
$cfg.Output.StackTraceVerbosity = "None"
$cfg.Run.Path                   = "$PSScriptRoot/*.tests.ps1"
$cfg.TestResult.OutputFormat    = "NUnitXml"
$cfg.TestResult.OutputPath      = "$PSScriptRoot/results.xml"
$cfg.TestResult.Enabled         = $True

# $cfg.Filter.Tag = "Devices"
$cfg.Filter.ExcludeTag = "Cables","Interfaces"

Invoke-Pester -Configuration $cfg