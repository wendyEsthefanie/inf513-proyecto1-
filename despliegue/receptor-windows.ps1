$ErrorActionPreference = 'Stop'
$Proyecto = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $Proyecto
$Mutex = New-Object System.Threading.Mutex($false, 'Local\CorreoAcademia22SC')
$Propietario = $false
try {
    try { $Propietario = $Mutex.WaitOne(0) }
    catch [System.Threading.AbandonedMutexException] { $Propietario = $true }
    if (-not $Propietario) { throw 'Ya hay un receptor administrado de Academia 22SC en esta sesión.' }
    if (-not (Test-Path '.env.remoto')) { throw 'Falta .env.remoto' }
    if (-not (Test-Path 'target/classes/org/academia/correo/ServicioEmail.class')) { throw 'Compile primero el proyecto.' }
    New-Item -ItemType Directory -Force logs | Out-Null
    Get-Content .env.remoto -Encoding UTF8 | ForEach-Object {
        if ($_ -match '^\s*([A-Za-z_][A-Za-z0-9_]*)=(.*)$') {
            $Nombre=$Matches[1]; $Valor=$Matches[2].Trim()
            if ($Valor.Length -ge 2 -and (($Valor.StartsWith('"') -and $Valor.EndsWith('"')) -or ($Valor.StartsWith("'") -and $Valor.EndsWith("'")))) { $Valor=$Valor.Substring(1,$Valor.Length-2) }
            [Environment]::SetEnvironmentVariable($Nombre,$Valor,'Process')
        }
    }
    $Java = if ($env:ACADEMIA_JAVA_BIN) { $env:ACADEMIA_JAVA_BIN } else { (Get-Command java -ErrorAction Stop).Source }
    if ($Java.Contains('"')) { throw 'Ruta Java inválida.' }
    $Info = New-Object System.Diagnostics.ProcessStartInfo
    $Info.FileName=$Java
    $Info.Arguments='-cp "target/classes;target/dependency/*" org.academia.correo.ServicioEmail --listen'
    $Info.WorkingDirectory=$Proyecto
    $Info.UseShellExecute=$false
    $Info.CreateNoWindow=$true
    $Proceso = New-Object System.Diagnostics.Process
    $Proceso.StartInfo=$Info
    [void]$Proceso.Start()
    $Proceso.Id | Set-Content -Encoding ascii '.receptor-windows.pid'
    $Proceso.WaitForExit()
    if ($Proceso.ExitCode -ne 0) { throw "Java terminó con código $($Proceso.ExitCode). Revisar logs del proyecto." }
}
catch {
    New-Item -ItemType Directory -Force logs | Out-Null
    Add-Content -Encoding UTF8 logs/tarea-windows.log "$(Get-Date -Format o) Fallo del lanzador: $($_.Exception.GetType().Name). Revise configuración, Java y registros del proyecto."
    exit 1
}
finally {
    if ($Propietario) {
        Remove-Item '.receptor-windows.pid' -ErrorAction SilentlyContinue
        $Mutex.ReleaseMutex()
    }
    $Mutex.Dispose()
}
