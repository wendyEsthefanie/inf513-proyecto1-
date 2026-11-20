@echo off
setlocal
cd /d "%~dp0"
where java >nul 2>nul
if errorlevel 1 (
 echo Se necesita Java 17 o superior para Windows instalado y disponible en PATH.
 pause
 exit /b 1
)
echo Iniciando Academia 22SC. Para detener, presione Ctrl+C.
powershell.exe -NoProfile -Command "$ErrorActionPreference='Stop'; try { Get-Content -LiteralPath '.env.remoto' -Encoding UTF8 | ForEach-Object { if ($_ -match '^\s*([A-Za-z_][A-Za-z0-9_]*)=(.*)$') { $n=$Matches[1]; $v=$Matches[2].Trim(); if ($v.Length -ge 2 -and (($v[0] -eq [char]34 -and $v[$v.Length-1] -eq [char]34) -or ($v[0] -eq [char]39 -and $v[$v.Length-1] -eq [char]39))) { $v=$v.Substring(1,$v.Length-2) }; [Environment]::SetEnvironmentVariable($n,$v,'Process') } }; & java -cp 'target/classes;target/dependency/*' org.academia.correo.ServicioEmail --listen; exit $LASTEXITCODE } catch { Write-Host $_.Exception.Message; exit 1 }"
if errorlevel 1 pause
