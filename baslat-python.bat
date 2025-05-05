@echo off
echo EcoSifaa Web Uygulamasi baslatiliyor...
echo ================================================
echo.
echo Onenemli Not: 
echo Eger renk degisikliklerini hala goremiyorsaniz, onbellegi temizlemek icin:
echo http://localhost:8080/yenile.html adresine gidin.
echo.
echo Web sitesi adresleri:
echo Onbellek Temizleme: http://localhost:8080/yenile.html
echo Ana Sayfa: http://localhost:8080
echo Admin Panel: http://localhost:8080/admin-panel.html
echo.
echo Kullanici Adi: admin
echo Sifre: admin123
echo ================================================
echo.
echo Sunucu baslatiliyor, tarayicinizda http://localhost:8080/yenile.html adresini acin
echo CTRL+C ile sunucuyu durdurabilirsiniz
echo.
cd /d "%~dp0web"
python -m http.server 8080
pause 