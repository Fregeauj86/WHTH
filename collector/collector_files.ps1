function Collect-Files {
    Write-Host "Collecting files..."
    $targetDirs = @(
        "$env:SystemRoot\System32",
        "$env:USERPROFILE\AppData\Local",
        "$env:USERPROFILE\AppData\Roaming",
        "$env:TEMP"
    )
    
    $output = @()
    
    foreach ($dir in $targetDirs) {
        if (Test-Path $dir) {
            Get-ChildItem -Path $dir -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
                $output += [PSCustomObject]@{
                    FullPath      = $_.FullName
                    Size          = $_.Length
                    LastWriteTime = $_.LastWriteTime
                    Attributes    = $_.Attributes
                }
            }
        }
    }
    
    $output | Export-Csv -Path "$PSScriptRoot\..\Logs\files.csv" -NoTypeInformation
    Write-Host "Files collection complete. Output: Logs\files.csv"
}