@echo off
:: Request Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
cd /d "%~dp0"
set SERVICE_NAME=MySQL80

:MENU
cls
echo ===========================
echo   MySQL 8.0 快捷管理脚本
echo ===========================
echo 任务说明：
echo   1 - 智能切换状态 (开启/关闭)
echo   2 - 开启 MySQL 8.0 服务
echo   3 - 关闭 MySQL 8.0 服务
echo ===========================

set choice=
set /p choice="请输入命令编号 (1/2/3): "

if "%choice%"=="1" goto TOGGLE
if "%choice%"=="2" goto STARTSVC
if "%choice%"=="3" goto STOPSVC
goto MENU

:TOGGLE
sc query %SERVICE_NAME% | find /I "RUNNING" >nul
if %ERRORLEVEL%==0 (
    echo.
    echo 检测到 [运行中]，正在关闭 %SERVICE_NAME%...
    net stop %SERVICE_NAME%
) else (
    echo.
    echo 检测到 [已关闭]，正在开启 %SERVICE_NAME%...
    net start %SERVICE_NAME%
)
goto ENDSVC

:STARTSVC
echo.
echo 正在开启 %SERVICE_NAME% 服务...
net start %SERVICE_NAME%
goto ENDSVC

:STOPSVC
echo.
echo 正在关闭 %SERVICE_NAME% 服务...
net stop %SERVICE_NAME%
goto ENDSVC

:ENDSVC
echo.
echo 操作完成，请按任意键退出...
pause >nul
exit /b

