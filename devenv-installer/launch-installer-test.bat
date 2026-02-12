@echo off
REM ============================================
REM TEST Launcher for "test-feature" branch
REM ============================================

REM Set console to UTF-8 for accents
chcp 65001 >nul

echo.
echo ========================================
echo  SUN DATA CONSULTING (TEST MODE)
echo  Branch: test-feature
echo ========================================
echo.

REM Configure PowerShell execution policy
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force" >nul 2>&1

SET "GITHUB_RAW_URL=https://raw.githubusercontent.com/ulrich-sun/automation-scripts/test-feature/devenv-installer/install-config-gui.ps1"
SET "TEMP_SCRIPT=%TEMP%\sdc-installer-test-%RANDOM%.ps1"

echo [INFO] Téléchargement depuis la branche 'test-feature'...
echo [INFO] Downloading from 'test-feature' branch...
echo URL: %GITHUB_RAW_URL%
echo.

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '%GITHUB_RAW_URL%' -OutFile '%TEMP_SCRIPT%' -UseBasicParsing; exit 0 } catch { Write-Host '[ERREUR] Echec du téléchargement'; Write-Host $_.Exception.Message; exit 1 }}"

if %errorLevel% neq 0 (
    echo.
    echo [ERREUR] Impossible de télécharger le script de test.
    pause
    exit /b 1
)

echo [INFO] Lancement de l'installateur de test...
echo.

powershell -ExecutionPolicy Bypass -File "%TEMP_SCRIPT%"

REM Cleanup
if exist "%TEMP_SCRIPT%" del /f /q "%TEMP_SCRIPT%" >nul 2>&1
