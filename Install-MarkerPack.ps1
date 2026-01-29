# BlishHUD Marker Pack Installer
# Automatically installs TacO/BlishHUD marker packs
# Works with any marker pack zip file
#
# Usage:
#   Install-MarkerPack.ps1                    # Auto-detect first .zip file
#   Install-MarkerPack.ps1 -ZipFileName "MyPack.zip"  # Specify exact file

param(
    [string]$ZipFileName = ""
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  BlishHUD Marker Pack Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find the zip file in the same directory as this script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($ZipFileName -ne "") {
    # User specified a zip file name
    $zipPath = Join-Path $scriptDir $ZipFileName
    if (Test-Path $zipPath) {
        $zipFile = Get-Item $zipPath
        Write-Host "Using specified marker pack: $($zipFile.Name)" -ForegroundColor Green
    } else {
        Write-Host "ERROR: Could not find specified zip file: $ZipFileName" -ForegroundColor Red
        Write-Host "Please make sure the file exists in the same folder as this script." -ForegroundColor Yellow
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    # Auto-detect first zip file
    $zipFile = Get-ChildItem -Path $scriptDir -Filter "*.zip" | Select-Object -First 1

    if (-not $zipFile) {
        Write-Host "ERROR: No zip file found in the same folder as this installer!" -ForegroundColor Red
        Write-Host "Please make sure your marker pack zip file is in the same folder as this script." -ForegroundColor Yellow
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    Write-Host "Found marker pack: $($zipFile.Name)" -ForegroundColor Green
}

# Find BlishHUD markers folder
$possiblePaths = @(
    "$env:USERPROFILE\Documents\Guild Wars 2\addons\blishhud\markers",
    "$env:USERPROFILE\Documents\Guild Wars 2\addons\BlishHUD\markers",
    "$env:APPDATA\Blish HUD\markers"
)

$markersPath = $null
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $markersPath = $path
        break
    }
}

if (-not $markersPath) {
    Write-Host "ERROR: Could not find BlishHUD markers folder!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Searched locations:" -ForegroundColor Yellow
    foreach ($path in $possiblePaths) {
        Write-Host "  - $path" -ForegroundColor Gray
    }
    Write-Host ""
    Write-Host "Please make sure BlishHUD is installed and has been run at least once." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Found BlishHUD markers folder: $markersPath" -ForegroundColor Green
Write-Host ""

# Create temporary extraction folder
$tempExtractPath = Join-Path $env:TEMP "MarkerPack_Install"
if (Test-Path $tempExtractPath) {
    Remove-Item $tempExtractPath -Recurse -Force
}

Write-Host "Extracting marker pack..." -ForegroundColor Cyan
try {
    Expand-Archive -Path $zipFile.FullName -DestinationPath $tempExtractPath -Force
    Write-Host "Extraction complete!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to extract zip file!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Copy files to BlishHUD markers folder
Write-Host "Installing markers to BlishHUD..." -ForegroundColor Cyan
try {
    Copy-Item -Path "$tempExtractPath\*" -Destination $markersPath -Recurse -Force
    Write-Host "Installation complete!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to copy files!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Clean up temp folder
Remove-Item $tempExtractPath -Recurse -Force

# Success message
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Installation Successful!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Marker pack has been installed to:" -ForegroundColor White
Write-Host "  $markersPath" -ForegroundColor Gray
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Launch Guild Wars 2" -ForegroundColor White
Write-Host "  2. Start BlishHUD" -ForegroundColor White
Write-Host "  3. Open the Pathing/Markers module" -ForegroundColor White
Write-Host "  4. Enable the marker categories you want" -ForegroundColor White
Write-Host ""

# List installed marker files
$xmlFiles = Get-ChildItem -Path $markersPath -Filter "*.xml" -ErrorAction SilentlyContinue
$tacoFiles = Get-ChildItem -Path $markersPath -Filter "*.taco" -ErrorAction SilentlyContinue

if ($xmlFiles.Count -gt 0 -or $tacoFiles.Count -gt 0) {
    Write-Host "Marker files in your BlishHUD folder:" -ForegroundColor Cyan
    foreach ($file in $xmlFiles) {
        Write-Host "  - $($file.Name)" -ForegroundColor White
    }
    foreach ($file in $tacoFiles) {
        Write-Host "  - $($file.Name)" -ForegroundColor White
    }
    Write-Host ""
}

Read-Host "Press Enter to exit"
