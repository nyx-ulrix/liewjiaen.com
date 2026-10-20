@echo off
title Portfolio GM
cd /d "%~dp0"
where node >nul 2>nul || (echo Node.js is needed to run the dashboard. Install the LTS version from https://nodejs.org and try again. & pause & exit /b 1)
node server.js
pause
