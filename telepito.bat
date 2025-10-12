@echo off
REM =====================================================
REM  CPS-MEZO-ELLENOR RENDSZER - TELEPITO v1.0
REM  Robot Framework alapú CPS30 rendszer tesztelés
REM  és mezőértékek ellenőrzése
REM =====================================================
setlocal EnableDelayedExpansion

echo.
echo =====================================================
echo   CPS-MEZO-ELLENOR RENDSZER TELEPITO v1.0
echo   
echo   Funkcionalitas:
echo   - CPS30 webes rendszer teszteles
echo   - Beszerzesi azonosito ellenorzes
echo   - Adatok validacio es ellenorzes
echo   - Automatikus bejelentkezes es navigacio
echo   - SeleniumLibrary webes automatizalas
echo =====================================================
echo.

REM Telepitesi konyvtar bekeres
echo Adja meg a telepitesi konyvtar eleresi utjat:
echo (pl: C:\DuplikacioEllenorzo vagy D:\MyProjects\DuplikacioSystem)
echo. 
REM Automatikus telepitesi konyvtar beallitasa: az aktualis folder nevében a DownloadedRobots kifejezést InstalledRobots-ra cseréljük
set "CURDIR=%CD%"
set "TARGET_DIR=%CURDIR:DownloadedRobots=InstalledRobots%"
echo [INFO] Alapertelmezett telepitesi konyvtar: %TARGET_DIR%
set /p USER_TARGET="Telepitesi konyvtar (ENTER = alapertelmezett): "
if not "%USER_TARGET%"=="" (
    set "TARGET_DIR=%USER_TARGET%"
) else (
    echo [INFO] Alapertelmezett konyvtar hasznalata: %TARGET_DIR%
)

REM Ha nem letezik a konyvtar, hozzuk letre
if not exist "%TARGET_DIR%" (
    echo [INFO] Telepitesi konyvtar letrehozasa: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
)
if "%TARGET_DIR%"=="" (
    echo HIBA: Nem adott meg telepitesi konyvtarat!
    pause
    exit /b 1
)

echo.
echo Telepitesi cel: %TARGET_DIR%
echo.

REM Chrome webdriver ellenorzes
echo Chrome webdriver ellenorzese...
where chromedriver >nul 2>&1
if errorlevel 1 (
    echo FIGYELEM: ChromeDriver nincs telepitve vagy nem elerheto a PATH-ban!
    echo.
    echo Megoldasok:
    echo 1. Telepitse a ChromeDriver-t es adja hozza a PATH-hoz
    echo 2. Vagy hasznaljon webdrivermanager-t (automatikus telepites)
    echo 3. Ellenorizze a Chrome bongeszo verziojaval valo kompatibilitast
    echo.
    echo A telepites folytatodik, de szukseges lehet a webdriver beallitasa...
    echo.
) else (
    echo ChromeDriver talalhato a rendszerben.
)

REM Ellenorizzuk a Python megletet es verziot
echo Python verzio ellenorzese...
python --version >nul 2>&1
if errorlevel 1 (
    echo HIBA: Python nincs telepitve vagy nem elerheto a PATH-ban!
    echo.
    echo Megoldasok:
    echo 1. Telepitse a Python 3.8+ verzioit a python.org oldalrol
    echo 2. Vagy hasznaja az Install\python-3.13.7-amd64.exe fajlt
    echo 3. Adja hoza a Python-t a rendszer PATH valtozojához
    echo.
    pause
    exit /b 1
)

echo Python verzio:
python --version

REM Python verzió ellenőrzés (3.8+ ajánlott)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Talalt Python verzio: %PYTHON_VERSION%

echo.
echo Python modullok ellenorzese...
python -c "import sys; print('Python executable:', sys.executable)"
echo.

REM Konyvtar letrehozasa ha nem letezik
if not exist "%TARGET_DIR%" (
    echo Konyvtar letrehozasa: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
    if errorlevel 1 (
        echo HIBA: Nem sikerult letrehozni a konyvtarat!
        pause
        exit /b 1
    )
) else (
    echo Konyvtar mar letezik: %TARGET_DIR%
)

echo.
echo Fajlok masolasa...

REM Szukseges dokumentacios fajlok masolasa
copy "README.md" "%TARGET_DIR%\"
if exist ".github\copilot-instructions.md" (
    copy ".github\copilot-instructions.md" "%TARGET_DIR%\"
)

REM Excel fajlok masolasa
if exist "eljárás.xlsx" copy "eljárás.xlsx" "%TARGET_DIR%\"
if exist "eljárás másolata.xlsx" copy "eljárás másolata.xlsx" "%TARGET_DIR%\"
if exist "Entitás adatok_eljárás&ajánlat_v3.xlsx" copy "Entitás adatok_eljárás&ajánlat_v3.xlsx" "%TARGET_DIR%\"

REM Resources mappa masolasa
if exist "resources" (
    echo Resources konyvtar masolasa...
    xcopy "resources" "%TARGET_DIR%\resources" /E /I /Y
) else (
    echo Resources konyvtar letrehozasa...
    mkdir "%TARGET_DIR%\resources"
)

REM Tests mappa masolasa
if exist "tests" (
    echo Tests konyvtar masolasa...
    xcopy "tests" "%TARGET_DIR%\tests" /E /I /Y
) else (
    echo Tests konyvtar letrehozasa...
    mkdir "%TARGET_DIR%\tests"
)

echo Fajlok sikeresen masolva.

REM Szukseges konyvtarak letrehozasa
echo Szukseges konyvtarak ellenorzese es letrehozasa...

REM Results konyvtar letrehozasa
if not exist "%TARGET_DIR%\results" (
    echo Results konyvtar letrehozasa...
    mkdir "%TARGET_DIR%\results"
)

REM Screenshots konyvtar letrehozasa (webes teszteleshez)
if not exist "%TARGET_DIR%\results\screenshots" (
    echo Screenshots konyvtar letrehozasa...
    mkdir "%TARGET_DIR%\results\screenshots"
)

REM Logs konyvtar letrehozasa
if not exist "%TARGET_DIR%\results\logs" (
    echo Logs konyvtar letrehozasa...
    mkdir "%TARGET_DIR%\results\logs"
)

echo.

REM Atlepunk a cel konyvtarba
cd /d "%TARGET_DIR%"

REM Virtualis kornyezet letrehozasa
echo Virtualis kornyezet letrehozasa...
if not exist "rf_env" (
    python -m venv rf_env
    if errorlevel 1 (
        echo HIBA: Virtualis kornyezet letrehozasa sikertelen!
        pause
        exit /b 1
    )
    echo Virtualis kornyezet sikeresen letrehozva.
) else (
    echo Virtualis kornyezet mar letezik.
)
echo.

REM Virtualis kornyezet aktivalasa es csomagok telepitese
echo Csomagok telepitese...
REM rf_env\Scripts\activate (nem szükséges, pip elérési út miatt)
REM requirements.txt fajl letrehozasa
echo robotframework > "%TARGET_DIR%\requirements.txt"
echo robotframework-seleniumlibrary >> "%TARGET_DIR%\requirements.txt"
echo robotframework-databaselibrary >> "%TARGET_DIR%\requirements.txt"
echo selenium >> "%TARGET_DIR%\requirements.txt"
echo openpyxl >> "%TARGET_DIR%\requirements.txt"
echo requests >> "%TARGET_DIR%\requirements.txt"

rf_env\Scripts\pip.exe install --upgrade pip
rf_env\Scripts\pip.exe install -r "%TARGET_DIR%\requirements.txt"

if errorlevel 1 (
    echo HIBA: Csomagok telepitese sikertelen!
    pause
    exit /b 1
)

echo.
echo start.bat fajl letrehozasa...

REM start.bat fajl letrehozasa
echo @echo off > start.bat
echo REM ========================================= >> start.bat
echo REM  FORMAI ELLENORZO RENDSZER FUTTATAS >> start.bat
echo REM ========================================= >> start.bat
echo echo. >> start.bat
echo echo ========================================= >> start.bat
echo echo   FORMAI ELLENORZO RENDSZER >> start.bat
echo echo   Main robot futtatas >> start.bat
echo echo ========================================= >> start.bat
echo echo. >> start.bat
echo. >> start.bat
echo REM Ellenorizzuk a virtualis kornyezet megletet >> start.bat
echo if not exist "rf_env\Scripts\robot.exe" ^( >> start.bat
echo     echo HIBA: Virtualis kornyezet nem talalhato! >> start.bat
echo     echo Futtassa eloszor a telepito.bat fajlt! >> start.bat
echo     pause >> start.bat
echo     exit /b 1 >> start.bat
echo ^) >> start.bat
echo. >> start.bat
echo REM ChromeDriver ellenorzes >> start.bat
echo echo ChromeDriver ellenorzese... >> start.bat
echo where chromedriver ^>nul 2^>^&1 >> start.bat
echo if errorlevel 1 ^( >> start.bat
echo     echo FIGYELEM: ChromeDriver nincs a PATH-ban! >> start.bat
echo     echo SeleniumLibrary megprobalja automatikusan kezelni a webdriver-t. >> start.bat
echo ^) >> start.bat
echo. >> start.bat
echo echo Konfiguracio ellenorzese... >> start.bat
echo if not exist "Duplikacio.config" ^( >> start.bat
echo     echo HIBA: Duplikacio.config fajl nem talalhato! >> start.bat
echo     echo Ellenorizze a konfiguracios fajlt! >> start.bat
echo     pause >> start.bat
echo     exit /b 1 >> start.bat
echo ^) >> start.bat
echo. >> start.bat
echo REM Results konyvtar letrehozasa ha nem letezik >> start.bat
echo if not exist "results" ^( >> start.bat
echo     echo Results konyvtar letrehozasa... >> start.bat
echo     mkdir "results" >> start.bat
echo ^) >> start.bat
echo. >> start.bat
echo echo Robot Framework teszt futtatasa... >> start.bat
echo echo Valasszon futtatasi modot: >> start.bat
echo echo 1. CPS30 bejelentkezes teszt ^(cps30_access.robot^) >> start.bat
echo echo 2. CPS30 eljaras teszt ^(cps30_eljaras.robot^) >> start.bat
echo echo 3. Beszerzesi azonosito ellenorzes ^(beszerzesi_azonosito_ellenorzes.robot^) >> start.bat
echo echo 4. CPS30 adatok ellenorzes ^(cps30_adatok_ellenorzes.robot^) >> start.bat
echo echo 5. Osszes teszt futtatasa ^(tests konyvtar^) >> start.bat
echo set /p MODE="Valasztas (1-5): " >> start.bat
echo. >> start.bat
echo if "%%MODE%%"=="1" ^( >> start.bat
echo     rf_env\Scripts\robot.exe --outputdir results tests\cps30_access.robot >> start.bat
echo ^) else if "%%MODE%%"=="2" ^( >> start.bat
echo     rf_env\Scripts\robot.exe --outputdir results tests\cps30_eljaras.robot >> start.bat
echo ^) else if "%%MODE%%"=="3" ^( >> start.bat
echo     rf_env\Scripts\robot.exe --outputdir results tests\beszerzesi_azonosito_ellenorzes.robot >> start.bat
echo ^) else if "%%MODE%%"=="4" ^( >> start.bat
echo     rf_env\Scripts\robot.exe --outputdir results tests\cps30_adatok_ellenorzes.robot >> start.bat
echo ^) else if "%%MODE%%"=="5" ^( >> start.bat
echo     rf_env\Scripts\robot.exe --outputdir results tests >> start.bat
echo ^) else ^( >> start.bat
echo     echo Ervenytelen valasztas, alapertelmezett: CPS30 adatok ellenorzes >> start.bat
echo     rf_env\Scripts\robot.exe --outputdir results tests\cps30_adatok_ellenorzes.robot >> start.bat
echo ^) >> start.bat
echo. >> start.bat
echo if errorlevel 1 ^( >> start.bat
echo     echo HIBA: A teszt futtatasa sikertelen! >> start.bat
echo     echo Ellenorizze a results\log.html fajlt a reszletekert. >> start.bat
echo ^) else ^( >> start.bat
echo     echo. >> start.bat
echo     echo ========================================= >> start.bat
echo     echo TESZT SIKERESEN BEFEJEZODOTT! >> start.bat
echo     echo. >> start.bat
echo     echo Eredmenyek: >> start.bat
echo     echo - Log: results\log.html >> start.bat
echo     echo - Report: results\report.html >> start.bat
echo     echo - Screenshots: results\screenshots >> start.bat
echo     echo ========================================= >> start.bat
echo ^) >> start.bat
echo. >> start.bat
echo pause >> start.bat

echo.
echo =========================================
echo TELEPITES SIKERES!
echo.
echo Telepitesi hely: %TARGET_DIR%
echo.
echo Telepitett komponensek:
echo - Robot Framework (tesztvezerlesi keretrendszer)
echo - SeleniumLibrary (webes automatizalas)
echo - Database Library (adatbazis kezeles)
echo - WebDriverManager (webdriver automatikus telepites)
echo - Selenium (webes bongeszo vezerlese)
echo - OpenPyXL (Excel fajlok kezelese)
echo - Requests (HTTP kliens)
echo - CPS30 projekt fajlok (tests, resources)
echo - start.bat futtato script
echo.
echo Hasznalat:
echo 1. Menjen a telepitesi konyvtarba: %TARGET_DIR%
echo 2. Futtassa: start.bat
echo 3. Valassza ki a futatni kivant tesztet
echo.
echo Tesztek: 
echo - cps30_access.robot: CPS30 bejelentkezes teszt
echo - cps30_eljaras.robot: CPS30 eljaras teszt
echo - beszerzesi_azonosito_ellenorzes.robot: Beszerzesi ID ellenorzes
echo - cps30_adatok_ellenorzes.robot: CPS30 adatok validacio
echo.
echo Eredmenyek: results\ konyvtar
echo Dokumentacio: README.md
echo =========================================
echo.
echo.
echo Szeretne most tesztelni a telepitett rendszert?
echo 1. Igen, futtas teszt (i)
echo 2. Nem, kesobb (n)
set /p TEST_NOW="Valasztas (i/n): "

if /i "%TEST_NOW%"=="i" (
    echo.
    echo CPS30 teszt futtatasa...
    cd /d "%TARGET_DIR%"
    call start.bat
) else (
    echo.
    echo A rendszer keszen all a hasznalatra!
    echo.
    echo Inditas: %TARGET_DIR%\start.bat
    echo Eredmenyek: %TARGET_DIR%\results\
)
echo.
pause
