@echo off
chcp 65001 >nul
rem ============================================================
rem  lab_system.bat - главный файл, объединяет три модуля
rem  Вариант 2: выбор текстового редактора для команды
rem ============================================================

rem Переходим в папку, где лежит сам файл. Тогда call и report.txt
rem работают одинаково при двойном клике, из ярлыка и из консоли.
cd /d "%~dp0"

rem --- Проверяем, что все модули на месте -------------------------------------
for %%f in (chapter1.bat chapter2.bat chapter3.bat) do (
    if not exist "%%f" (
        echo Не найден файл %%f. Положите все .bat файлы в одну папку.
        pause
        exit /b 1
    )
)

:menu
cls
echo ========================================================
echo   СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo   Вариант 2: выбор текстового редактора для команды
echo ========================================================
echo.
echo   1. Модуль выбора технологий
echo   2. Модуль инспекции кода
echo   3. Модуль сравнительного анализа
echo   4. Запустить все модули последовательно
echo   5. Выход
echo.
choice /c 12345 /n /m "Ваш выбор: "
rem Сразу сохраняем результат choice: errorlevel изменится после любой команды
set menu_item=%errorlevel%

if "%menu_item%"=="1" call chapter1.bat
if "%menu_item%"=="2" call chapter2.bat
if "%menu_item%"=="3" call chapter3.bat
if "%menu_item%"=="4" goto run_all
if "%menu_item%"=="5" goto end
goto menu

:run_all
rem Переменные result1, result2, result3 остаются в памяти после call,
rem потому что модули выполняются в том же окне cmd.
set result1=
set result2=
set result3=
call chapter1.bat
call chapter2.bat
call chapter3.bat
cls
call :report
pause
goto menu

:end
exit /b

rem ============================================================
rem  Подпрограмма :report - итоговый отчёт на экран и в report.txt
rem ============================================================
:report
if "%result1%"=="%result3%" (
    set "verdict=Модули 1 и 3 указывают на один и тот же редактор - выбор хорошо обоснован."
) else (
    set "verdict=Модули 1 и 3 дали разные результаты - стоит обсудить критерии с командой."
)
(
    echo ========================================================
    echo   ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
    echo   Вариант 2: выбор текстового редактора для команды
    echo ========================================================
    echo Дата и время: %date% %time:~0,8%
    echo.
    echo Модуль 1. Рекомендация по технологии : %result1%
    echo    Баллы - Sublime Text: %score_sublime%, Atom: %score_atom%, Notepad++: %score_notepadpp%
    echo Модуль 2. Уровень ревьюера           : %result2%
    echo    Верных ответов: %correct% из %total%, точность %percent%%%
    echo Модуль 3. Победитель анализа WSM     : %result3%
    echo    Итоги S - Sublime Text: %score_s%, Atom: %score_a%, Notepad++: %score_n%
    echo.
    echo Вывод: %verdict%
) > report.txt
type report.txt
echo.
echo Отчёт сохранён в файл: %~dp0report.txt
exit /b
