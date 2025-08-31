function Collect-Network {
    Write-Output "Collect-Network: Collecting network configuration..."
    
    $logPath = Join-Path $PSScriptRoot "..\Logs"
    if (-Not (Test-Path $logPath)) {
        New-Item -ItemType Directory -Path $logPath | Out-Null
    }

    $outputFile = Join-Path $logPath "network_log.txt"

    $output = @()

    # Basic IP config
    $output += "===== IP Configuration ====="
    $output += (ipconfig /all)

    # Active network connections
    $output += "`n===== Active Connections ====="
    $output += (Get-NetTCPConnection | Format-Table -AutoSize | Out-String)

    # Routing table
    $output += "`n===== Routing Table ====="
    $output += (route print)

    # Firewall rules (basic summary)
    $output += "`n===== Firewall Rules ====="
    $output += (Get-NetFirewallRule | Select-Object DisplayName, Direction, Action, Enabled | Out-String)

    # Save all output
    $output | Out-File $outputFile -Encoding UTF8

    Write-Output "Network info saved to $outputFile"
}