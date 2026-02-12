@echo off
REM ============================================
REM Launcher: Vagrant Stack Manager
REM SUN DATA CONSULTING
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

REM Configure PowerShell execution policy
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force" >nul 2>&1

REM Check for Git
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

echo [INFO] Lancement de l'application...
echo [INFO] Launching application...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0vagrant-stack-manager.ps1"

if %errorLevel% neq 0 (
    echo.
    echo [ERREUR] Une erreur est survenue.
    pause
)
