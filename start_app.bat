@echo off
echo ========================================
echo SFIA - Starting Application
echo ========================================
echo.

REM Check if virtual environment exists
if not exist ".venv" (
    echo ERROR: Virtual environment not found!
    echo Please run setup_env.bat first to set up the environment.
    pause
    exit /b 1
)

REM Activate virtual environment
echo Activating virtual environment...
call .venv\Scripts\activate.bat
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment
    pause
    exit /b 1
)

echo Virtual environment activated successfully!
echo.

REM Check if Ollama is running
echo Checking Ollama server status...
curl -s http://localhost:11434/api/tags >nul 2>&1
if errorlevel 1 (
    echo.
    echo WARNING: Ollama server does not appear to be running.
    echo Please start Ollama server with: ollama serve
    echo.
    echo Do you want to continue anyway? (y/n)
    set /p choice=
    if /i not "%choice%"=="y" (
        echo Application startup cancelled.
        pause
        exit /b 1
    )
) else (
    echo Ollama server is running.
)

echo.
echo ========================================
echo SFIA - Semantic File Information Assistant
echo ========================================
echo.
echo Usage examples:
echo   python main.py
echo   python main.py "What is machine learning?"
echo   python main.py "Explain AI" --doc-folder ./documents
echo   python main.py "Hello" --debug
echo.
echo Type 'python main.py --help' for all options.
echo.
echo Press Ctrl+C to exit.
echo ========================================
echo.

REM Start the application with default question
python main.py

echo.
echo Application closed.
pause 