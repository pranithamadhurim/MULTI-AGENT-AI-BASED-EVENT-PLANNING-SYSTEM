@echo off
echo ==========================================================
echo Starting Multi-Agent AI Event Planning System
echo ==========================================================

start "FastAPI Backend" cmd /k "cd /d %~dp0backend && py -3.11 run.py"
start "React Frontend" cmd /k "cd /d %~dp0frontend && ..\tools\node-v20.18.0-win-x64\npm.cmd run dev"

echo Backend launching on: http://127.0.0.1:8000
echo Frontend launching on: http://localhost:5173
echo ==========================================================
