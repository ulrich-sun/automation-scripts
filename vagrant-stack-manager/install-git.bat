@echo off
REM SUN DATA CONSULTING
REM Author: Ulrich Steve NOUMSI

echo Installing Git...
winget install --id Git.Git -e --source winget
if %errorLevel% neq 0 (
    echo Git installation failed. Please install manually from https://git-scm.com/download/win
    pause
) else (
    echo Git installed successfully! You may need to restart the script/terminal.
    pause
)
