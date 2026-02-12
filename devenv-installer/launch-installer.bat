@echo off
REM ============================================
REM GitHub-Based Installer Launcher
REM Lanceur d'Installation basé sur GitHub
REM 
REM Company: SUN DATA CONSULTING
REM Repository: automation-scripts
REM ============================================

SETLOCAL EnableDelayedExpansion

REM ============================================
REM CONFIGURATION - Modify this section
REM ============================================
REM GitHub Repository Configuration
SET "GITHUB_USER=ulrich-sun"
SET "GITHUB_REPO=automation-scripts"
SET "SCRIPT_PATH=devenv-installer/install-config-gui.ps1"

REM Construct GitHub Raw URL
SET "GITHUB_RAW_URL=https://raw.githubusercontent.com/%GITHUB_USER%/%GITHUB_REPO%/main/%SCRIPT_PATH%"

REM Temporary directory for downloaded script
SET "TEMP_SCRIPT=%TEMP%\sdc-installer-%RANDOM%.ps1"

REM ============================================
REM MAIN SCRIPT - Do not modify below this line
REM ============================================

echo.
echo ========================================
echo  SUN DATA CONSULTING
echo  Development Environment Installer
echo  Installateur d'Environnement de Dev
echo ========================================
echo.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERREUR/ERROR] Ce script necessite des privileges administrateur.
    echo [ERREUR/ERROR] This script requires administrator privileges.
    echo.
    echo Veuillez executer en tant qu'administrateur (clic droit ^> Executer en tant qu'administrateur^)
    echo Please run as administrator (right-click ^> Run as administrator^)
    echo.
    pause
    exit /b 1
)

echo [OK] Privileges administrateur detectes / Administrator privileges detected
echo.

REM Configure PowerShell execution policy
echo [INFO] Configuration de la politique d'execution PowerShell...
echo [INFO] Configuring PowerShell execution policy...
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force" >nul 2>&1

if %errorLevel% neq 0 (
    echo [WARN] Impossible de configurer la politique d'execution
    echo [WARN] Failed to configure execution policy
    echo [INFO] Tentative de continuer quand meme...
    echo [INFO] Attempting to continue anyway...
)

echo [OK] Politique d'execution configuree / Execution policy configured
echo.

REM Download PowerShell script from GitHub
echo [INFO] Telechargement du script depuis GitHub...
echo [INFO] Downloading script from GitHub...
echo [INFO] URL: %GITHUB_RAW_URL%
echo.

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '%GITHUB_RAW_URL%' -OutFile '%TEMP_SCRIPT%' -UseBasicParsing; exit 0 } catch { Write-Host '[ERREUR/ERROR] Echec du telechargement / Download failed'; Write-Host $_.Exception.Message; exit 1 }}"

if %errorLevel% neq 0 (
    echo.
    echo [ERREUR/ERROR] Impossible de telecharger le script depuis GitHub
    echo [ERREUR/ERROR] Failed to download script from GitHub
    echo.
    echo Verifiez:
    echo - Votre connexion Internet / Your internet connection
    echo - L'URL du depot GitHub / The GitHub repository URL
    echo - Que le fichier existe dans le depot / That the file exists in the repository
    echo.
    echo URL configuree / Configured URL: %GITHUB_RAW_URL%
    echo.
    pause
    exit /b 1
)

echo [OK] Script telecharge avec succes / Script downloaded successfully
echo.

REM Execute the downloaded PowerShell script
echo [INFO] Lancement de l'installateur GUI...
echo [INFO] Launching GUI installer...
echo.

powershell -ExecutionPolicy Bypass -File "%TEMP_SCRIPT%"

SET INSTALLER_EXIT_CODE=%errorLevel%

REM Clean up temporary file
echo.
echo [INFO] Nettoyage des fichiers temporaires...
echo [INFO] Cleaning up temporary files...
if exist "%TEMP_SCRIPT%" del /f /q "%TEMP_SCRIPT%" >nul 2>&1

if %INSTALLER_EXIT_CODE% neq 0 (
    echo.
    echo [ERREUR/ERROR] L'installation a rencontre une erreur
    echo [ERREUR/ERROR] Installation encountered an error
    echo.
    pause
    exit /b %INSTALLER_EXIT_CODE%
)

echo.
echo [OK] Installation terminee / Installation completed
echo.
pause
