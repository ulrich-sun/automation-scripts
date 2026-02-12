@echo off
REM ============================================
REM Launcher: Vagrant Stack Manager
REM SUN DATA CONSULTING
REM Author: Ulrich Steve NOUMSI
REM ============================================

REM Set console to UTF-8 for accents
chcp 65001 >nul

echo.
echo ========================================
echo  SUN DATA CONSULTING
echo  Vagrant Stack Manager
echo ========================================
echo.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERREUR] Ce script nécessite des privilièges administrateur.
    echo [ERROR] This script requires administrator privileges.
    echo.
    pause
    exit /b 1
)

REM ============================================
REM CONFIGURATION
REM ============================================
SET "GITHUB_USER=ulrich-sun"
SET "GITHUB_REPO=automation-scripts"
SET "SCRIPT_PATH=vagrant-stack-manager/vagrant-stack-manager.ps1"
SET "GITHUB_RAW_URL=https://raw.githubusercontent.com/%GITHUB_USER%/%GITHUB_REPO%/main/%SCRIPT_PATH%"
SET "TEMP_SCRIPT=%TEMP%\stack-manager-%RANDOM%.ps1"

REM Check for Git (Prerequisite)
git --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERREUR] Git n'est pas installé ou détecté.
    echo [ERROR] Git is not installed or detected.
    echo.
    echo Veuillez installer Git pour continuer : https://git-scm.com/download/win
    echo Please install Git to continue: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo [INFO] Téléchargement de la dernière version depuis GitHub...
echo [INFO] Downloading latest version from GitHub...

REM Download script using PowerShell (TLS 1.2 support)
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '%GITHUB_RAW_URL%' -OutFile '%TEMP_SCRIPT%' -UseBasicParsing; exit 0 } catch { Write-Host '[ERREUR/ERROR] Echec du téléchargement / Download failed'; Write-Host $_.Exception.Message; exit 1 }}"

if %errorLevel% neq 0 (
    echo.
    echo [ERREUR] Impossible de télécharger le script. Vérifiez votre connexion internet.
    echo [ERROR] Could not download the script. Check your internet connection.
    pause
    exit /b 1
)

echo [INFO] Lancement de l'application...
echo [INFO] Launching application...
echo.

REM Execute the downloaded script
powershell -ExecutionPolicy Bypass -File "%TEMP_SCRIPT%"

REM Cleanup
if exist "%TEMP_SCRIPT%" del /f /q "%TEMP_SCRIPT%" >nul 2>&1

