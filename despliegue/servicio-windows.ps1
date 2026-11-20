param([ValidateSet('instalar','iniciar','detener','estado','automatico','manual','logs','desinstalar')][string]$Accion='estado')
$ErrorActionPreference='Stop'
$Proyecto=Split-Path -Parent $PSScriptRoot
$Nombre='CorreoAcademia22SC'
function Detener-Receptor {
    $Archivo=Join-Path $Proyecto '.receptor-windows.pid'
    $Numero=0
    if (Test-Path $Archivo) {
        if ([int]::TryParse((Get-Content $Archivo -Raw).Trim(),[ref]$Numero)) {
            $Proceso=Get-CimInstance Win32_Process -Filter "ProcessId=$Numero"
            if ($Proceso -and $Proceso.CommandLine -like '*org.academia.correo.ServicioEmail*') {
                Stop-Process -Id $Numero -ErrorAction SilentlyContinue
            }
        }
        Remove-Item $Archivo -ErrorAction SilentlyContinue
    }
    Stop-ScheduledTask -TaskName $Nombre -ErrorAction SilentlyContinue
}
switch ($Accion) {
    instalar {
        if (Get-ScheduledTask -TaskName $Nombre -ErrorAction SilentlyContinue) { throw 'La tarea ya existe; desinstálela antes de reemplazarla.' }
        if (-not (Test-Path (Join-Path $Proyecto '.env.remoto'))) { throw 'Falta .env.remoto' }
        if (-not (Test-Path (Join-Path $Proyecto 'target/classes/org/academia/correo/ServicioEmail.class'))) { throw 'Compile primero con Maven.' }
        $Java=(Get-Command java -ErrorAction Stop).Source
        # La tarea recibe una ruta absoluta de Java mediante un archivo local sin secretos.
        $Java | Set-Content -Encoding UTF8 (Join-Path $PSScriptRoot 'java-windows.local')
        $Lanzador=Join-Path $PSScriptRoot 'iniciar-tarea-windows.ps1'
        $Powershell=Join-Path $env:SystemRoot 'System32/WindowsPowerShell/v1.0/powershell.exe'
        $Ejecutar=New-ScheduledTaskAction -Execute $Powershell -Argument "-NoProfile -NonInteractive -WindowStyle Hidden -File `"$Lanzador`"" -WorkingDirectory $Proyecto
        $Usuario=[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        $Disparador=New-ScheduledTaskTrigger -AtLogOn -User $Usuario
        $Identidad=New-ScheduledTaskPrincipal -UserId $Usuario -LogonType Interactive -RunLevel Limited
        $Opciones=New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -ExecutionTimeLimit ([TimeSpan]::Zero) -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1) -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
        Register-ScheduledTask -TaskName $Nombre -Action $Ejecutar -Trigger $Disparador -Principal $Identidad -Settings $Opciones | Out-Null
        Write-Host 'Tarea instalada para iniciar con la sesión. No se ha iniciado ahora.'
    }
    iniciar { Start-ScheduledTask -TaskName $Nombre }
    detener { Detener-Receptor }
    estado { Get-ScheduledTask -TaskName $Nombre | Select-Object TaskName,State; Get-ScheduledTaskInfo -TaskName $Nombre | Select-Object LastRunTime,LastTaskResult }
    automatico { Enable-ScheduledTask -TaskName $Nombre | Out-Null }
    manual { Disable-ScheduledTask -TaskName $Nombre | Out-Null }
    logs { Get-Content (Join-Path $Proyecto 'logs/access.log') -Tail 30 -Wait }
    desinstalar { Detener-Receptor; Unregister-ScheduledTask -TaskName $Nombre -Confirm:$false }
}
