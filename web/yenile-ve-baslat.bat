@echo off
echo EcoSifaa Web Uygulamasi yenileniyor ve baslatiliyor...
echo ================================================
echo.
echo NOT: Eger renkler hala dogru gozukmuyorsa, tarayicinizda:
echo 1. CTRL+SHIFT+DELETE tusuna basin
echo 2. "Onbellegi Temizle" secenegini isaretleyin
echo 3. "Degisiklikleri Temizle" veya "Simdi Temizle" tusuna basin
echo 4. Sayfayi yeniden yukleyin (CTRL+F5)
echo.
echo Web sitesi adresleri:
echo Ana Sayfa: http://localhost:8080
echo Admin Panel: http://localhost:8080/admin-panel.html
echo.
echo Kullanici Adi: admin
echo Sifre: admin123
echo ================================================
echo.
echo Sunucu baslatiliyor, tarayicinizda http://localhost:8080 adresini acin
echo CTRL+C ile sunucuyu durdurabilirsiniz
echo.
cd /d "%~dp0"
python -m http.server 8080
pause 