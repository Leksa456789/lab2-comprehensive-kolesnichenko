@echo off
chcp 65001 >nul
rem ============================================================
rem  chapter2.bat - Модуль 2. Инспекция кода
rem  Вариант 2: код настройки и плагинов текстового редактора
rem ============================================================

rem --- Обнуляем счётчики ---
set correct=0
set total=5
set points=0
set result2=

cls
echo ========================================================
echo   МОДУЛЬ 2. ИНСПЕКЦИЯ КОДА
echo   Фрагменты: код настройки и плагинов текстового редактора
echo ========================================================
echo.
echo В каждом фрагменте спрятан один дефект. Типы дефектов:
echo   1. Неинициализированная переменная
echo   2. Мёртвое присваивание
echo   3. Утечка ресурса
echo   4. Магическое число
echo   5. Отсутствие обработки ошибок
echo За верный ответ +10 очков, за неверный -5.
echo.

echo --------------------------------------------------------
echo Фрагмент 1 из 5 - автосохранение
echo 10: def setup_autosave(editor):
echo 11:     editor.autosave_interval = 30000
echo 12:     editor.autosave_enabled = True
echo 13:     return editor
echo.
call :check 4 "магическое число" "Значение 30000 лучше вынести в константу, например AUTOSAVE_INTERVAL_MS."

echo --------------------------------------------------------
echo Фрагмент 2 из 5 - чтение конфигурации редактора
echo 20: def load_editor_config(path):
echo 21:     try:
echo 22:         f = open(path, "r")
echo 23:         text = f.read()
echo 24:     except OSError:
echo 25:         return {}
echo 26:     return parse_settings(text)
echo.
call :check 3 "утечка ресурса" "Файл открыт, но нигде не закрывается. Нужен with open или f.close."

echo --------------------------------------------------------
echo Фрагмент 3 из 5 - установка плагина
echo 30: def install_plugin(name):
echo 31:     url = REPO_URL + "/" + name + ".zip"
echo 32:     data = download(url)
echo 33:     unpack(data, PLUGINS_DIR)
echo 34:     return True
echo.
call :check 5 "отсутствие обработки ошибок" "Загрузка и распаковка могут упасть, а try/except нет."

echo --------------------------------------------------------
echo Фрагмент 4 из 5 - подсчёт открытых вкладок
echo 40: def count_open_tabs(windows):
echo 41:     for w in windows:
echo 42:         total += len(w.tabs)
echo 43:     return total
echo.
call :check 1 "неинициализированная переменная" "Переменная total используется в строке 42 без начального значения. Нужно total = 0 перед циклом."

echo --------------------------------------------------------
echo Фрагмент 5 из 5 - выбор темы оформления
echo 50: def pick_theme(user):
echo 51:     theme = "light"
echo 52:     theme = user.settings.get("theme", "dark")
echo 53:     return theme
echo.
call :check 2 "мёртвое присваивание" "Значение из строки 51 перезаписывается в строке 52 и нигде не используется."

rem --- Итоговый отчёт ---------------------------------------------------------
echo.
echo ========================================================
echo   ИТОГОВЫЙ ОТЧЁТ РЕВЬЮЕРА
echo ========================================================
set /a percent=correct*100/total
set /a wrong=total-correct
echo Просмотрено фрагментов : %total%
echo Правильных ответов     : %correct%
echo Неправильных ответов   : %wrong%
echo Очков                  : %points%
echo Точность               : %percent%%%
if %percent% geq 80 (
    set "result2=Senior Reviewer"
) else if %percent% geq 50 (
    set "result2=Middle Reviewer"
) else (
    set "result2=Junior Reviewer"
)
echo Уровень ревьюера       : %result2%
echo.
pause
exit /b

rem ============================================================
rem  Подпрограмма :check
rem  %1 - номер правильного ответа
rem  %2 - название дефекта
rem  %3 - пояснение
rem ============================================================
:check
echo Тип дефекта: 1-неинициализированная  2-мёртвое присваивание  3-утечка ресурса
echo              4-магическое число  5-нет обработки ошибок
choice /c 12345 /n /m "Ваш ответ: "
set answer=%errorlevel%
echo.
if "%answer%"=="%~1" (
    echo [+] Верно! Дефект: %~2.
    set /a "correct+=1, points+=10"
) else (
    echo [-] Неверно. Правильный ответ: %~1 - %~2.
    set /a "points-=5"
)
echo     Пояснение: %~3
echo.
exit /b
