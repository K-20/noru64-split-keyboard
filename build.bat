@echo off
REM ZMK Build Script for Noru64 Split Keyboard
REM Usage: build.bat [board]
REM Example: build.bat noru64_split_center
REM Example: build.bat all

setlocal enabledelayedexpansion

REM Set paths
set "ZEPHYR_BASE=%~dp0zephyr"
set "ZMK_APP=%~dp0zmk\app"
set "CONFIG_PATH=%~dp0config"
set "ZEPHYR_TOOLCHAIN_VARIANT=zephyr"

echo === ZMK Build Script for Noru64 Split Keyboard ===
echo Zephyr Base: %ZEPHYR_BASE%
echo ZMK App: %ZMK_APP%
echo Config Path: %CONFIG_PATH%
echo.

REM Check if cmake is available
cmake --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: cmake not found. Please install cmake and add it to PATH.
    exit /b 1
)

REM Check if ninja is available
ninja --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ninja not found. Please install ninja and add it to PATH.
    exit /b 1
)

REM Set board parameter
set "BOARD=%1"
if "%BOARD%"=="" set "BOARD=all"

REM Function to build a board
:build_board
set "BOARD_NAME=%1"
echo Building %BOARD_NAME%...

REM Create build directory
set "BUILD_DIR=%ZMK_APP%\build_%BOARD_NAME%"
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%BUILD_DIR%"

REM Change to build directory
pushd "%BUILD_DIR%"

REM Configure with cmake
echo Configuring %BOARD_NAME%...
cmake -G "Ninja" -DBOARD=%BOARD_NAME% -DZMK_CONFIG=%CONFIG_PATH% %ZMK_APP%
if errorlevel 1 (
    echo Configuration failed for %BOARD_NAME%
    popd
    exit /b 1
)

REM Build with ninja
echo Building %BOARD_NAME%...
ninja
if errorlevel 1 (
    echo Build failed for %BOARD_NAME%
    popd
    exit /b 1
)

REM Check for firmware file
if exist "zephyr\zmk.uf2" (
    echo Build successful for %BOARD_NAME%
    
    REM Copy firmware to config directory
    copy "zephyr\zmk.uf2" "%CONFIG_PATH%\firmware_%BOARD_NAME%.uf2" >nul
    echo Firmware copied to: %CONFIG_PATH%\firmware_%BOARD_NAME%.uf2
) else (
    echo Firmware file not found for %BOARD_NAME%
    popd
    exit /b 1
)

popd
goto :eof

REM Main build logic
if "%BOARD%"=="all" (
    call :build_board noru64_split_center
    if errorlevel 1 exit /b 1
    call :build_board noru64_split_peripheral
    if errorlevel 1 exit /b 1
) else (
    call :build_board %BOARD%
    if errorlevel 1 exit /b 1
)

echo.
echo === Build Summary ===
echo All builds completed successfully!
echo.
echo Firmware files available in: %CONFIG_PATH%
dir /b "%CONFIG_PATH%\firmware_*.uf2" 2>nul
echo.
echo You can now flash the firmware to your keyboards.
