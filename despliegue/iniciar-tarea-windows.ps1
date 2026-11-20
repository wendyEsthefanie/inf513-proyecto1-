$ErrorActionPreference='Stop'
$env:ACADEMIA_JAVA_BIN=(Get-Content (Join-Path $PSScriptRoot 'java-windows.local') -Raw -Encoding UTF8).Trim()
& (Join-Path $PSScriptRoot 'receptor-windows.ps1')
