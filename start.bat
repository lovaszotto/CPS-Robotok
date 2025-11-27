@echo off
chcp 65001 >nul
set PYTHONIOENCODING=utf-8
REM ========================================= 
REM  FORMAI ELLENORZO RENDSZER FUTTATAS 
REM ========================================= 
echo. 
echo ========================================= 
echo   FORMAI ELLENORZO RENDSZER 
echo   Main robot futtatas 
echo ========================================= 
echo. 
 
REM Ellenorizzuk a virtualis kornyezet megletet 
if not exist ".venv\Scripts\robot.exe" ( 
    echo HIBA: Virtualis kornyezet nem talalhato 
    echo Futtassa eloszor a telepito.bat fajlt 
    pause 
    exit /b 1 
) 
 

 
REM Results konyvtar letrehozasa ha nem letezik 
if not exist "results" ( 
    echo Results konyvtar letrehozasa... 
    mkdir "results" 
) 
 
echo Robot Framework teszt futtatasa... 
echo CPS30 adatok ellenorzes futtatasa...
 
.venv\Scripts\robot.exe --outputdir results tests\cps30_adatok_ellenorzes.robot 
 
if errorlevel 1 ( 
    echo HIBA: A teszt futtatasa sikertelen 
    echo Ellenorizze a results\log.html fajlt a reszletekert. 
) else ( 
    echo. 
    echo ========================================= 
    echo TESZT SIKERESEN BEFEJEZODOTT 
    echo. 
    echo Eredmenyek: 
    echo - Log: results\log.html 
    echo - Report: results\report.html 
    echo - Email elkuldve a konfiguralt cimre 
    echo ========================================= 
) 
exit 0
