Write-Host "=== Threat Hunter Collection Script Started ===" -ForegroundColor Cyan

# Define collectors relative to this script
$Collectors = @(
    "collector_network.ps1",
    "collector_services_drivers.ps1",
    "collector_persistence.ps1",
    "collector_files.ps1"
)

foreach ($Collector in $Collectors) {
    $FullPath = Join-Path $PSScriptRoot $Collector
    if (Test-Path $FullPath) {
        Write-Host "Running $Collector..." -ForegroundColor Yellow
        try {
            & $FullPath
        }
        catch {
            Write-Warning "Error running ${Collector}: $_"
        }
    }
    else {
        Write-Warning "Collector not found: $FullPath"
    }
}

Write-Host "=== Threat Hunter Collection Complete ===" -ForegroundColor Green