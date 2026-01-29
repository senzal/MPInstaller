@echo off
REM BlishHUD Marker Pack Installer Launcher
REM
REM USAGE:
REM   - Leave MARKER_PACK_NAME empty to auto-detect the first .zip file
REM   - Or specify the exact zip filename (e.g., SET MARKER_PACK_NAME=MyPack_v1.2.zip)
REM

REM ============================================
REM CONFIGURATION (Edit this section if needed)
REM ============================================
SET MARKER_PACK_NAME=

REM ============================================
REM DO NOT EDIT BELOW THIS LINE
REM ============================================

if "%MARKER_PACK_NAME%"=="" (
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0Install-MarkerPack.ps1"
) else (
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0Install-MarkerPack.ps1" -ZipFileName "%MARKER_PACK_NAME%"
)
pause
