@echo off
chcp 65001 >nul
rem ============================================================
rem  chapter3.bat - Модуль 3. Сравнительный анализ методом WSM
rem  Вариант 2: Sublime Text / Atom / Notepad++
rem  Формула: S = W1*X1 + W2*X2 + W3*X3 + W4*X4
rem ============================================================

set result3=

cls
echo ========================================================
echo   МОДУЛЬ 3. СРАВНИТЕЛЬНЫЙ АНАЛИЗ МЕТОДОМ ВЗВЕШЕННОЙ СУММЫ
echo   Альтернативы: Sublime Text, Atom, Notepad++
echo ========================================================
echo.
echo Критерии сравнения:
echo   1. Скорость работы
echo   2. Плагины и расширяемость
echo   3. Стоимость владения, где 5 = бесплатно, а 1 = дорого
echo   4. Простота освоения

rem --- Шаг 1. Веса критериев с проверкой суммы = 100 ------------------------
:weights
echo.
echo ШАГ 1. Назначьте веса критериям: целые числа, сумма должна быть 100.
call :askw w1 "Вес критерия 1, Скорость работы"
call :askw w2 "Вес критерия 2, Плагины и расширяемость"
call :askw w3 "Вес критерия 3, Стоимость владения"
call :askw w4 "Вес критерия 4, Простота освоения"
set /a total_weight=w1+w2+w3+w4
if %total_weight% neq 100 (
    echo.
    echo ОШИБКА: сумма весов равна %total_weight%, а должна быть 100. Введите веса заново.
    goto weights
)
echo Сумма весов равна 100. Продолжаем.

rem --- Шаг 2. Оценки альтернатив по шкале 1-5 -------------------------------
echo.
echo ШАГ 2. Оцените каждый редактор по шкале от 1 до 5.
echo        1 - очень плохо, 5 - отлично. Для стоимости: 5 = бесплатно.
echo.
echo --- Критерий 1: Скорость работы ---
call :rate s_1 "Sublime Text"
call :rate a_1 "Atom"
call :rate n_1 "Notepad++"
echo.
echo --- Критерий 2: Плагины и расширяемость ---
call :rate s_2 "Sublime Text"
call :rate a_2 "Atom"
call :rate n_2 "Notepad++"
echo.
echo --- Критерий 3: Стоимость владения, 5 = бесплатно ---
call :rate s_3 "Sublime Text"
call :rate a_3 "Atom"
call :rate n_3 "Notepad++"
echo.
echo --- Критерий 4: Простота освоения ---
call :rate s_4 "Sublime Text"
call :rate a_4 "Atom"
call :rate n_4 "Notepad++"

rem --- Шаг 3. Расчёт S = сумма W*X ------------------------------------------
set /a score_s=s_1*w1+s_2*w2+s_3*w3+s_4*w4
set /a score_a=a_1*w1+a_2*w2+a_3*w3+a_4*w4
set /a score_n=n_1*w1+n_2*w2+n_3*w3+n_4*w4
rem Максимум возможен при оценках 5 по всем критериям: 5*100 = 500
set /a pct_s=score_s*100/500
set /a pct_a=score_a*100/500
set /a pct_n=score_n*100/500

rem --- Выравнивание весов по правому краю: добавляем пробелы слева -----------
set "pw1=  %w1%"
set "pw2=  %w2%"
set "pw3=  %w3%"
set "pw4=  %w4%"

rem --- Матрица решений ------------------------------------------------------
echo.
echo ========================================================
echo   МАТРИЦА РЕШЕНИЙ
echo ========================================================
echo Критерий                      Вес  Sublime  Atom  Notepad++
echo -----------------------------------------------------------
echo Скорость работы               %pw1:~-3%        %s_1%     %a_1%          %n_1%
echo Плагины и расширяемость       %pw2:~-3%        %s_2%     %a_2%          %n_2%
echo Стоимость, 5 = бесплатно      %pw3:~-3%        %s_3%     %a_3%          %n_3%
echo Простота освоения             %pw4:~-3%        %s_4%     %a_4%          %n_4%
echo -----------------------------------------------------------
echo ИТОГО S = сумма W*X           %total_weight%      %score_s%   %score_a%        %score_n%
echo.
echo Sublime Text : %score_s% из 500, это %pct_s%%%
echo Atom         : %score_a% из 500, это %pct_a%%%
echo Notepad++    : %score_n% из 500, это %pct_n%%%
echo.

rem --- Определяем победителя; при равенстве перечисляем всех лидеров -----------
set best=%score_s%
if %score_a% gtr %best% set best=%score_a%
if %score_n% gtr %best% set best=%score_n%

set count=0
set "result3="
if %score_s% equ %best% set "result3=Sublime Text"
if %score_s% equ %best% set /a count+=1
if %score_a% equ %best% if defined result3 (set "result3=%result3% и Atom") else set "result3=Atom"
if %score_a% equ %best% set /a count+=1
if %score_n% equ %best% if defined result3 (set "result3=%result3% и Notepad++") else set "result3=Notepad++"
if %score_n% equ %best% set /a count+=1

echo ПОБЕДИТЕЛЬ: %result3%
if %count% gtr 1 echo Внимание: у лидеров одинаковое число баллов, это ничья.
echo.
pause
exit /b

rem ============================================================
rem  Подпрограмма :askw - ввод веса с проверкой
rem  %1 - имя переменной, %2 - подпись
rem  Принимаются только числа 0, 1-9, 10-99, 100-999 без ведущих нулей
rem ============================================================
:askw
set "tmp_w="
set /p "tmp_w=%~2: "
echo %tmp_w%|findstr /r /x "[0-9] [1-9][0-9] [1-9][0-9][0-9]" >nul
if errorlevel 1 (
    echo   Ошибка: введите целое число от 0 до 100.
    goto askw
)
set /a %~1=%tmp_w%
exit /b

rem ============================================================
rem  Подпрограмма :rate - оценка от 1 до 5 одной клавишей
rem  %1 - имя переменной, %2 - название редактора
rem ============================================================
:rate
choice /c 12345 /n /m "   %~2, оценка 1-5: "
set /a %~1=%errorlevel%
exit /b
