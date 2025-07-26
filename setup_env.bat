@echo off
echo ========================================
echo SFIA - Environment Setup
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.10+ from https://python.org
    pause
    exit /b 1
)

echo Python found: 
python --version
echo.

REM Check if virtual environment already exists
if exist ".venv" (
    echo Virtual environment already exists.
    echo Do you want to recreate it? (y/n)
    set /p choice=
    if /i "%choice%"=="y" (
        echo Removing existing virtual environment...
        rmdir /s /q .venv
    ) else (
        echo Skipping virtual environment creation.
        goto :activate_env
    )
)

echo Creating virtual environment...
python -m venv .venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)

:activate_env
echo.
echo Activating virtual environment...
call .venv\Scripts\activate.bat
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment
    pause
    exit /b 1
)

echo Virtual environment activated successfully!
echo.

echo Installing dependencies...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo ========================================
echo Environment setup completed successfully!
echo ========================================
echo.
echo Next steps:
echo 1. Start Ollama server: ollama serve
echo 2. Pull required model: ollama pull llama3.2:latest
echo 3. Run the application: start_app.bat
echo.
pause 