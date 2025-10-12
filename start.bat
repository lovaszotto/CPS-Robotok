@echo off 
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
if not exist "rf_env\Scripts\robot.exe" ( 
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
echo Valasszon futtatasi modot: 
echo 1. Formai ellenorzes (PLG-00-main.robot) 
echo 2. Excel kitolto (PLG-02-Excel-kitolto.robot) 
echo 3. Test Cases (PLG-04-FormaiEllenorzes-TestCases.robot) 
echo 4. DOCX Reader teszt (test_docxReader.robot) 
set /p MODE="Valasztas (1-4): " 
 
if "%MODE%"=="1" ( 
    rf_env\Scripts\robot.exe --outputdir results PLG-00-main.robot 
) else if "%MODE%"=="2" ( 
    rf_env\Scripts\robot.exe --outputdir results PLG-02-Excel-kitolto.robot 
) else if "%MODE%"=="3" ( 
    rf_env\Scripts\robot.exe --outputdir results PLG-04-FormaiEllenorzes-TestCases.robot 
) else if "%MODE%"=="4" ( 
    rf_env\Scripts\robot.exe --outputdir results test_docxReader.robot 
) else ( 
    echo Ervenytelen valasztas, alapertelmezett: formai ellenorzes 
    rf_env\Scripts\robot.exe --outputdir results PLG-00-main.robot 
) 
 
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
 
pause 
