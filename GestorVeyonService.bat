@echo off
title Gestor de VeyonService
color 0F

:: Comprobacion de permisos de administrador

net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    color 4F
    echo =============================================
    echo   AVISO: NO SE EJECUTA COMO ADMINISTRADOR
    echo =============================================
    echo.
    echo  Este script necesita permisos de administrador.
    echo  Cierra esta ventana, haz clic derecho sobre el
    echo  archivo y elige "Ejecutar como administrador".
    echo.
    pause
    exit /b 1
)

:menu
cls
color 0F
echo =============================================
echo            GESTOR DE VEYONSERVICE
echo =============================================
echo.
echo   1. Desactivar VeyonService (detener servicio)
echo   2. Desactivar inicio automatico de VeyonService
echo   3. Reactivar inicio automatico y arrancar VeyonService
echo   0. Salir
echo.
echo =============================================
choice /c 1230 /n /m "Elige una opcion: "

if errorlevel 4 goto salir
if errorlevel 3 goto opcion3
if errorlevel 2 goto opcion2
if errorlevel 1 goto opcion1
goto menu

:opcion1
echo.
echo Deteniendo VeyonService...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Stop-Service -Name VeyonService -Force"
if %errorlevel% equ 0 (
    echo [OK] VeyonService detenido.
) else (
    echo [ERROR] No se pudo detener VeyonService.
)
echo.
pause
goto menu

:opcion2
echo.
echo Desactivando el inicio automatico de VeyonService...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Service -Name VeyonService -StartupType Disabled"
if %errorlevel% equ 0 (
    echo [OK] Inicio automatico desactivado.
) else (
    echo [ERROR] No se pudo desactivar el inicio automatico.
)
echo.
pause
goto menu

:opcion3
echo.
echo Reactivando el inicio automatico y arrancando VeyonService...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Service -Name VeyonService -StartupType Automatic; Start-Service -Name VeyonService"
if %errorlevel% equ 0 (
    echo [OK] Inicio automatico reactivado y servicio iniciado.
) else (
    echo [ERROR] No se pudo reactivar o iniciar VeyonService.
)
echo.
pause
goto menu

:salir
exit /b 0
