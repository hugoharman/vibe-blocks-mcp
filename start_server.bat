@echo off
REM Vibe Blocks MCP Server Startup Script
REM This script starts the MCP server for Roblox Studio integration

echo Starting Vibe Blocks MCP Server...
echo.

REM Check if we're in the correct directory
if not exist "src\roblox_mcp\server.py" (
    echo Error: Cannot find server.py file. Make sure you're running this from the project root directory.
    echo Expected location: src\roblox_mcp\server.py
    pause
    exit /b 1
)

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH.
    echo Please install Python 3.10 or higher and try again.
    pause
    exit /b 1
)

REM Start the server
echo Server will be available at: http://localhost:8000
echo MCP SSE endpoint: http://localhost:8000/sse
echo Plugin endpoint: http://localhost:8000/plugin_command
echo.
echo Press Ctrl+C to stop the server
echo.

uvicorn src.roblox_mcp.server:app --port 8000 --reload

REM If uvicorn fails, show error message
if errorlevel 1 (
    echo.
    echo Error: Failed to start the server.
    echo Make sure all dependencies are installed by running:
    echo   pip install -r requirements.txt
    echo   pip install "mcp[cli]>=1.3.0"
    echo.
    pause
)