@echo off
echo ============================================
echo  Generate Laravel APP_KEY for Production
echo ============================================
echo.

php artisan key:generate --show

echo.
echo Copy APP_KEY di atas ke Railway Variables!
echo.
pause
