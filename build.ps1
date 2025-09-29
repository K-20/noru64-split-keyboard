# ZMK Build Script for Noru64 Split Keyboard
# Usage: .\build.ps1 [board] [clean]
# Example: .\build.ps1 noru64_split_center
# Example: .\build.ps1 all clean

param(
    [string]$Board = "all",
    [switch]$Clean = $false
)

# Set paths
$ZephyrBase = "C:\Users\K\Downloads\Video\zmk-master\noru64_split\zephyr"
$ZmkApp = "C:\Users\K\Downloads\Video\zmk-master\noru64_split\zmk\app"
$ConfigPath = "C:\Users\K\Downloads\Video\zmk-master\noru64_split\config"

# Set environment variables
$env:ZEPHYR_BASE = $ZephyrBase
$env:ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"

Write-Host "=== ZMK Build Script for Noru64 Split Keyboard ===" -ForegroundColor Green
Write-Host "Zephyr Base: $ZephyrBase" -ForegroundColor Yellow
Write-Host "ZMK App: $ZmkApp" -ForegroundColor Yellow
Write-Host "Config Path: $ConfigPath" -ForegroundColor Yellow
Write-Host ""

# Function to build a specific board
function Build-Board {
    param([string]$BoardName)
    
    Write-Host "Building $BoardName..." -ForegroundColor Cyan
    
    # Create build directory
    $BuildDir = "$ZmkApp\build_$BoardName"
    if (Test-Path $BuildDir) {
        Remove-Item -Recurse -Force $BuildDir
    }
    New-Item -ItemType Directory -Path $BuildDir | Out-Null
    
    # Change to build directory
    Push-Location $BuildDir
    
    try {
        # Configure with cmake
        Write-Host "Configuring $BoardName..." -ForegroundColor Yellow
        & cmake -G "Ninja" -DBOARD=$BoardName -DZMK_CONFIG=$ConfigPath $ZmkApp
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Configuration failed for $BoardName" -ForegroundColor Red
            return $false
        }
        
        # Build with ninja
        Write-Host "Building $BoardName..." -ForegroundColor Yellow
        & ninja
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Build failed for $BoardName" -ForegroundColor Red
            return $false
        }
        
        # Check for firmware file
        $FirmwareFile = "zephyr\zmk.uf2"
        if (Test-Path $FirmwareFile) {
            $FileSize = (Get-Item $FirmwareFile).Length
            Write-Host "✅ Build successful for $BoardName" -ForegroundColor Green
            Write-Host "Firmware: $FirmwareFile ($FileSize bytes)" -ForegroundColor Green
            
            # Copy firmware to config directory
            $DestFile = "$ConfigPath\firmware_$BoardName.uf2"
            Copy-Item $FirmwareFile $DestFile
            Write-Host "Firmware copied to: $DestFile" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ Firmware file not found for $BoardName" -ForegroundColor Red
            return $false
        }
    }
    finally {
        Pop-Location
    }
}

# Clean build directories
if ($Clean) {
    Write-Host "Cleaning build directories..." -ForegroundColor Yellow
    $BuildDirs = @("$ZmkApp\build_*", "$ZmkApp\build")
    foreach ($Dir in $BuildDirs) {
        if (Test-Path $Dir) {
            Remove-Item -Recurse -Force $Dir
            Write-Host "Cleaned: $Dir" -ForegroundColor Yellow
        }
    }
}

# Build boards
$Boards = @("noru64_split_center", "noru64_split_peripheral")
$SuccessCount = 0
$TotalCount = 0

if ($Board -eq "all") {
    foreach ($BoardName in $Boards) {
        $TotalCount++
        if (Build-Board $BoardName) {
            $SuccessCount++
        }
    }
} else {
    if ($Boards -contains $Board) {
        $TotalCount = 1
        if (Build-Board $Board) {
            $SuccessCount = 1
        }
    } else {
        Write-Host "❌ Unknown board: $Board" -ForegroundColor Red
        Write-Host "Available boards: $($Boards -join ', ')" -ForegroundColor Yellow
        exit 1
    }
}

# Summary
Write-Host ""
Write-Host "=== Build Summary ===" -ForegroundColor Green
Write-Host "Successful builds: $SuccessCount/$TotalCount" -ForegroundColor $(if ($SuccessCount -eq $TotalCount) { "Green" } else { "Red" })

if ($SuccessCount -gt 0) {
    Write-Host ""
    Write-Host "Firmware files available in: $ConfigPath" -ForegroundColor Green
    Get-ChildItem "$ConfigPath\firmware_*.uf2" | ForEach-Object {
        Write-Host "  - $($_.Name)" -ForegroundColor Green
    }
}

if ($SuccessCount -eq $TotalCount) {
    Write-Host ""
    Write-Host "🎉 All builds completed successfully!" -ForegroundColor Green
    Write-Host "You can now flash the firmware to your keyboards." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "❌ Some builds failed. Check the output above for details." -ForegroundColor Red
    exit 1
}
