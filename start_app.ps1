# SFIA - Starting Application PowerShell Script
Write-Host "========================================" -ForegroundColor Green
Write-Host "SFIA - Starting Application" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check if virtual environment exists
if (-not (Test-Path ".venv")) {
    Write-Host "ERROR: Virtual environment not found!" -ForegroundColor Red
    Write-Host "Please run setup_env.bat first to set up the environment." -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& .venv\Scripts\Activate.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to activate virtual environment" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host "Virtual environment activated successfully!" -ForegroundColor Green
Write-Host ""

# Start the application with provided arguments or default
if ($args.Count -eq 0) {
    Write-Host "Starting with default question..." -ForegroundColor Yellow
    & .venv\Scripts\python.exe main.py
} else {
    Write-Host "Starting with custom arguments: $($args -join ' ')" -ForegroundColor Yellow
    & .venv\Scripts\python.exe main.py @args
}

Write-Host ""
Write-Host "Application closed." -ForegroundColor Green
Read-Host "Press Enter to continue" 