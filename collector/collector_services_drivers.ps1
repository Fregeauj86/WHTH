function Collect-ServicesDrivers {
    Write-Output "Collect-ServicesDrivers: Collecting services and drivers info..."
    
    $logPath = Join-Path $PSScriptRoot "..\Logs"
    if (-Not (Test-Path $logPath)) {
        New-Item -ItemType Directory -Path $logPath | Out-Null
    }

    $outputFile = Join-Path $logPath "services_drivers_log.txt"

    try {
        # Collect running services
        $services = Get-Service | Select-Object Name, DisplayName, Status, StartType

        # Collect drivers info
        $drivers = Get-WmiObject Win32_SystemDriver | 
                   Select-Object Name, DisplayName, State, StartMode, PathName

        # Save results
        "=== Services ===" | Out-File $outputFile
        $services | Format-Table | Out-String | Out-File $outputFile -Append

        "`n=== Drivers ===" | Out-File $outputFile -Append
        $drivers | Format-Table | Out-String | Out-File $outputFile -Append

        Write-Output "Services and drivers info saved to $outputFile"
    }
    catch {
        Write-Output "Error collecting services/drivers info: $_"
    }
}