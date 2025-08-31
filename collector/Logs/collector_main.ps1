# collector_main.ps1
Write-Output "=== Threat Hunter Collection Script Started ==="

# Define the collectors you want to run
$collectors = @(
    "collector_persistence.ps1",
    "collector_services_drivers.ps1",
    "collector_network.ps1",
    "collector_files.ps1"
)

# Base folder for collectors
$collectorPath = Join-Path $PSScriptRoot "Files"

foreach ($collector in $collectors) {
    $scriptFile = Join-Path $collectorPath $collector
    if (Test-Path $scriptFile) {
        Write-Output "`n--- Running $collector ---"
        . $scriptFile
    }
    else {
        Write-Warning "Collector not found: $scriptFile"
    }
}

Write-Output "`n=== Threat Hunter Collection Complete ==="
