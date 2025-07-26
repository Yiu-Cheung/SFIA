@echo off
echo ========================================
echo SFIA - Starting Application (Simple)
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

echo Virtual environment activated successfully!
echo.

REM Start the application
echo Starting application...

REM Check if arguments were provided
if "%1"=="" (
    echo Starting interactive mode...
    echo Type 'quit' or 'exit' to close the application.
    echo.
    
    :loop
    set /p question="Enter your question: "
    if /i "%question%"=="quit" goto :end
    if /i "%question%"=="exit" goto :end
    if "%question%"=="" goto :loop
    
    echo.
    .venv\Scripts\python.exe main.py "%question%" --doc-folder ".\doc"
    echo.
    goto :loop
    
    :end
    echo Application closed.
) else (
    echo Running with provided arguments...
    .venv\Scripts\python.exe main.py %*
    echo.
    echo Application closed.
)

pause 