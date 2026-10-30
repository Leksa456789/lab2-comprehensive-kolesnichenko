@echo off
chcp 65001 >nul
rem ============================================================
rem  chapter1.bat - Модуль 1. Выбор текстового редактора
rem  Вариант 2: Sublime Text / Atom / Notepad++
rem  Контекст: команда из 8 разработчиков, ограниченный бюджет
rem ============================================================

rem --- Шаг 0. Обнуляем баллы. Это важно при повторном запуске из меню ---
set score_sublime=0
set score_atom=0
set score_notepadpp=0
set result1=

cls
echo ========================================================
echo   МОДУЛЬ 1. ВЫБОР ТЕКСТОВОГО РЕДАКТОРА ДЛЯ КОМАНДЫ
echo   Кандидаты: Sublime Text, Atom, Notepad++
echo   Контекст: команда из 8 разработчиков, ограниченный бюджет
echo ========================================================
echo.
echo Ответьте на 7 вопросов о проекте. Нажимайте цифру нужного ответа.
echo.

rem --- Вопрос 1. БЮДЖЕТ -------------------------------------------------
echo Вопрос 1 из 7. Какой бюджет на лицензии ПО для редактора?
echo   1. Бюджета нет, только бесплатное ПО
echo   2. Небольшой, лицензии можно купить не всем
echo   3. Бюджет есть, готовы платить за удобство
choice /c 123 /n /m "Ваш ответ: "
set p_budget=%errorlevel%
rem Баллы идут в порядке: Sublime, Atom, Notepad++
if "%p_budget%"=="1" set /a "score_sublime+=0,  score_atom+=15, score_notepadpp+=15"
if "%p_budget%"=="2" set /a "score_sublime+=8,  score_atom+=10, score_notepadpp+=12"
if "%p_budget%"=="3" set /a "score_sublime+=15, score_atom+=8,  score_notepadpp+=8"
echo.

rem --- Вопрос 2. МАСШТАБ ------------------------------------------------
echo Вопрос 2 из 7. Каков масштаб проекта и размер файлов?
echo   1. Небольшие проекты и скрипты
echo   2. Средний проект, сотни файлов
echo   3. Крупный проект, огромные файлы и логи
choice /c 123 /n /m "Ваш ответ: "
set p_scale=%errorlevel%
if "%p_scale%"=="1" set /a "score_sublime+=8,  score_atom+=10, score_notepadpp+=10"
if "%p_scale%"=="2" set /a "score_sublime+=12, score_atom+=8,  score_notepadpp+=10"
if "%p_scale%"=="3" set /a "score_sublime+=15, score_atom+=0,  score_notepadpp+=8"
echo.

rem --- Вопрос 3. СРОКИ --------------------------------------------------
echo Вопрос 3 из 7. Какие сроки у проекта?
echo   1. Жёсткие, начинаем сразу, без настройки инструментов
echo   2. Умеренные
echo   3. Время есть, можно настроить редактор под себя
choice /c 123 /n /m "Ваш ответ: "
set p_deadline=%errorlevel%
if "%p_deadline%"=="1" set /a "score_sublime+=10, score_atom+=5,  score_notepadpp+=15"
if "%p_deadline%"=="2" set /a "score_sublime+=10, score_atom+=8,  score_notepadpp+=10"
if "%p_deadline%"=="3" set /a "score_sublime+=12, score_atom+=12, score_notepadpp+=6"
echo.

rem --- Вопрос 4. КВАЛИФИКАЦИЯ КОМАНДЫ ----------------------------------
echo Вопрос 4 из 7. Какова квалификация команды?
echo   1. В основном начинающие, нужна простота
echo   2. Смешанная команда
echo   3. Опытные, любят кастомизацию и горячие клавиши
choice /c 123 /n /m "Ваш ответ: "
set p_skill=%errorlevel%
if "%p_skill%"=="1" set /a "score_sublime+=8,  score_atom+=8,  score_notepadpp+=15"
if "%p_skill%"=="2" set /a "score_sublime+=12, score_atom+=10, score_notepadpp+=10"
if "%p_skill%"=="3" set /a "score_sublime+=15, score_atom+=10, score_notepadpp+=5"
echo.

rem --- Вопрос 5. ОПЕРАЦИОННЫЕ СИСТЕМЫ ----------------------------------
echo Вопрос 5 из 7. На каких операционных системах работает команда?
echo   1. Только Windows
echo   2. Windows плюс macOS или Linux
echo   3. В основном macOS или Linux
choice /c 123 /n /m "Ваш ответ: "
set p_os=%errorlevel%
if "%p_os%"=="1" set /a "score_sublime+=10, score_atom+=10, score_notepadpp+=15"
if "%p_os%"=="2" set /a "score_sublime+=15, score_atom+=12, score_notepadpp+=0"
if "%p_os%"=="3" set /a "score_sublime+=15, score_atom+=12, score_notepadpp+=0"
echo.

rem --- Вопрос 6. ПЛАГИНЫ ------------------------------------------------
echo Вопрос 6 из 7. Насколько важны плагины и расширяемость?
echo   1. Достаточно минимума
echo   2. Нужен стандартный набор плагинов
echo   3. Нужна широкая экосистема и гибкая настройка
choice /c 123 /n /m "Ваш ответ: "
set p_plugins=%errorlevel%
if "%p_plugins%"=="1" set /a "score_sublime+=5,  score_atom+=5,  score_notepadpp+=10"
if "%p_plugins%"=="2" set /a "score_sublime+=10, score_atom+=8,  score_notepadpp+=10"
if "%p_plugins%"=="3" set /a "score_sublime+=15, score_atom+=12, score_notepadpp+=6"
echo.

rem --- Вопрос 7. ПОДДЕРЖКА ----------------------------------------------
echo Вопрос 7 из 7. Насколько важна активная поддержка и обновления редактора?
echo   1. Критично: нужны обновления и исправления
echo   2. Не критично
choice /c 12 /n /m "Ваш ответ: "
set p_support=%errorlevel%
if "%p_support%"=="1" set /a "score_sublime+=15, score_atom+=0,  score_notepadpp+=15"
if "%p_support%"=="2" set /a "score_sublime+=5,  score_atom+=10, score_notepadpp+=5"

rem --- Вывод профиля и баллов ---------------------------------------------
echo.
echo ========================================================
echo   РЕЗУЛЬТАТ
echo ========================================================
echo Профиль проекта, числа = номера выбранных ответов:
echo   бюджет=%p_budget%, масштаб=%p_scale%, сроки=%p_deadline%, команда=%p_skill%,
echo   ОС=%p_os%, плагины=%p_plugins%, поддержка=%p_support%
echo.
echo Баллы кандидатов:
echo   Sublime Text : %score_sublime%
echo   Atom         : %score_atom%
echo   Notepad++    : %score_notepadpp%
echo.

rem --- Выбор победителя -----------------------------------------------------
rem Побеждает больший балл. При равенстве приоритет у более дешёвого:
rem сначала Notepad++, затем Atom, затем Sublime Text.
if %score_notepadpp% geq %score_sublime% if %score_notepadpp% geq %score_atom% goto win_npp
if %score_atom% geq %score_sublime% goto win_atom
goto win_sublime

:win_npp
set "result1=Notepad++"
set "comment1=Бесплатный и лёгкий, но работает только в Windows."
goto show_result

:win_atom
set "result1=Atom"
set "comment1=Бесплатный и гибкий, но GitHub прекратил развитие Atom в 2022 году - обновлений нет."
goto show_result

:win_sublime
set "result1=Sublime Text"
set "comment1=Быстрый и удобный, но лицензии платные - заложите бюджет на 8 рабочих мест."

:show_result
echo РЕКОМЕНДАЦИЯ: %result1%
echo %comment1%
echo.
pause
exit /b
