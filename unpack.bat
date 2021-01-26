::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFDpQRRCbPVeeCaIS5Of66/m7t0MNVeE0NYPU3bvAKeMcig==
::YAwzuBVtJxjWCl3EqQJhSA==
::ZR4luwNxJguZRRnVphFQ
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCqDJGur2X4FJgtVTw+LMmz3EroT5NTu4fqGoUYYRqw6YIq7
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
cls
echo.  
set name=Unpacking And Repacking v1.0   
set authors=[by Aditya Singh]  

set python=bin\windows\python\python.exe
set imgextractorpy=bin\windows\python\tools\imgextractor.py
set img2sdatpy=bin\windows\python\tools\img2sdat.py
set sdat2imgpy=bin\windows\tools\sdat2img.py
   
set busybox=bin\windows\busybox.exe
set brotli=bin\windows\brotli.exe
set sdat2img=bin\windows\sdat2img.exe
set imgextractor=bin\windows\imgextractor.exe
set img2sdat=bin\windows\img2sdat.exe
set simg2img=bin\windows\simg2img.exe
set imgsimg=bin\windows\img2simg.exe
set 7z=bin\w\super\7z.exe
set e2fs=bin\windows\e2fs.exe
set sfk=bin\windows\sfk.exe
set verity=bin\windows\rmverity.exe
set payload=bin\windows\payload.exe
set system_root=port\system
set vendor_root=port\vendor
set /p systemsize=<"port\system_size.txt"
set /p vendorsize=<"port\vendor_size.txt"
title %name% [v1.0] %authors%     
:main_menu 
cls          
echo "+------------------------------------------------+"
echo "|   Unpacking & repacking v1.0 by Aditya Singh   |"
echo "+------------------------------------------------+"
echo.
echo 1. Unpacking Rom 
echo 2. Unpack Super 
echo 3. Increase system and vendor block size
echo 4. remove dmverity
echo 5. Rebuild ROM
echo 6. sign zip (Note: It work in same directory)
echo 7. Decompiler apk 
echo 8. recompile apk
echo 9. unpack system and repack
echo 10. Payload Extract
echo 11. clean all
echo 12. Exit
echo.
set /p number=* Select an option: 
if "%number%"=="1" goto unpacking
if "%number%"=="2" goto unpacksuper
if "%number%"=="3" goto resize
if "%number%"=="4" goto removeverity
if "%number%"=="5" goto rebuild
if "%number%"=="6" goto signzip
if "%number%"=="7" goto decompileapk
if "%number%"=="8" goto recompileapk
if "%number%"=="9" goto unpack_system_and_repack
if "%number%"=="10" goto payload_extract
if "%number%"=="11" goto clean
if "%number%"=="12" goto Exit
if not "%number%"=="1" if not "%number%"=="2" if not "%number%"=="3" if not "%number%"=="4" if not "%number%"=="5" if not "%number%"=="6" if not "%number%"=="7" if not "%number%"=="7" if not "%number%"=="8" if not "%number%"=="9" if not "%number%"=="10" if not "%number%"=="11" if not "%number%"=="12" goto main_menu 

:unpacking
cls

if exist *.txt del *.txt > nul
echo.
echo -------------------------------------------->> log.txt
echo      Unpacking and repacking v1.0         >> log.txt
echo           By %authors%            >> log.txt
echo -------------------------------------------->> log.txt
  
if exist bin\tmp rd /s /q bin\tmp
if exist port rd /s /q port
if not exist bin\tmp mkdir bin\tmp
if not exist port mkdir port 
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta %dialog%') do set "file=%%p" 
if exist port ( 
echo - Extracting started... 
echo - Extracting %file% >> log.txt
bin\windows\7z x "%file%" -obin\tmp >> log.txt
) else (
echo. No dir found
)

rem if exist port.zip (
rem echo -   Extracting zip     
rem %busybox% unzip -o port.zip -d bin\tmp >nul
rem ) else (
rem echo error zip not found
rem )

cls
echo.
echo   Unpacking started...  
echo.
if exist bin\tmp\system.new.dat.br (
echo -   Unpack system.new.dat.br  
%brotli% -d bin\tmp\system.new.dat.br >nul >> log.txt
del bin\tmp\system.new.dat.br
)
if exist bin\tmp\vendor.new.dat.br (
echo -   Unpack vendor.new.dat.br  
%brotli% -d bin\tmp\vendor.new.dat.br >nul >> log.txt
del bin\tmp\vendor.new.dat.br
)

rem if exist bin\tmp\product.new.dat.br (
rem echo -   Unpack product.new.dat.br
rem %brotli% -d bin\tmp\product.new.dat.br >nul
rem del bin\tmp\product.new.dat.br
rem )

rem if exist bin\tmp\odm.new.dat.br (
rem echo -   Unpack odm.new.dat.br
rem %brotli% -d bin\tmp\odm.new.dat.br >nul
rem del bin\tmp\odm.new.dat.br
rem )

if exist bin\tmp\system.new.dat (
echo -   Unpack system.new.dat  
%sdat2img% bin\tmp\system.transfer.list bin\tmp\system.new.dat bin\tmp\system.img >nul >> log.txt
del bin\tmp\system.new.dat
del bin\tmp\system.transfer.list
del bin\tmp\system.patch.dat
)

if exist bin\tmp\vendor.new.dat (
echo -   Unpack vendor.new.dat  
%sdat2img% bin\tmp\vendor.transfer.list bin\tmp\vendor.new.dat bin\tmp\vendor.img >nul 2>nul >> log.txt
del bin\tmp\vendor.new.dat
del bin\tmp\vendor.transfer.list
del bin\tmp\vendor.patch.dat
)

rem if exist bin\tmp\product.new.dat (
rem echo -   Unpack product.new.dat
rem %sdat2img% bin\tmp\product.transfer.list bin\tmp\product.new.dat bin\tmp\product.img >nul 
rem del bin\tmp\product.new.dat
rem del bin\tmp\product.transfer.list
rem del bin\tmp\product.patch.dat
rem )

if exist bin\tmp\odm.new.dat (
echo -   Unpack odm.new.dat  
%sdat2img% bin\tmp\odm.transfer.list bin\tmp\odm.new.dat bin\tmp\odm.img >nul 2>nul  >> log.txt
del bin\tmp\odm.new.dat
del bin\tmp\odm.transfer.list
del bin\tmp\odm.patch.dat
)

if exist bin\tmp\system.img (
echo -   Unpack system.img 
%imgextractor% bin\tmp\system.img port\system >nul 2>nul  >> log.txt
rem del bin\tmp\system.img
)

if exist bin\tmp\vendor.img (
echo -   Unpack vendor.img
%imgextractor% bin\tmp\vendor.img port\vendor >nul 2>nul  >> log.txt
rem del bin\tmp\vendor.img
)

rem if exist bin\tmp\product.img (
rem echo -   Unpack product.img
rem %imgextractor% bin\tmp\product.img port\product >nul 2>nul
rem del bin\tmp\product.img
)

rem if exist bin\tmp\odm.img (
rem echo -   Unpack odm.img
rem %imgextractor% bin\tmp\odm.img port\odm >nul 2>nul
rem del bin\tmp\odm.img
rem )


set tmp=bin\tmp
if exist %tmp%\system_file_contexts move /y %tmp%\system_file_contexts port\  >nul 2>nul
if exist %tmp%\vendor_file_contexts move /y %tmp%\vendor_file_contexts port\  >nul 2>nul
if exist %tmp%\system_fs_config move /y %tmp%\system_fs_config port\  >nul 2>nul
if exist %tmp%\vendor_fs_config move /y %tmp%\vendor_fs_config port\  >nul 2>nul
if exist %tmp%\boot.img move /y %tmp%\boot.img port\  >nul 2>nul
if exist %tmp%\odm.img move /y %tmp%\odm.img port\  >nul 2>nul
if exist %tmp%\dynamic_partitions_op_list move /y %tmp%\dynamic_partitions_op_list port\  >nul 2>nul
if exist %tmp%\compatibility.zip move /y %tmp%\compatibility.zip port  >nul 2>nul
if exist %tmp%\compatibility_no_nfc.zip move /y %tmp%\compatibility_no_nfc.zip port\  >nul 2>nul
if exist %tmp%\install move /y %tmp%\install port\install  >nul 2>nul
if exist %tmp%\firmware-update move /y %tmp%\firmware-update port\  >nul 2>nul
if exist %tmp%\META-INF move /y %tmp%\META-INF port\  >nul 2>nul
if exist %tmp%\system move /y %tmp%\system port\system2  >nul 2>nul
if exist %tmp%\product.new.dat.br move /y %tmp%\product.new.dat.br port\  >nul 2>nul
if exist %tmp%\product.patch.dat move /y %tmp%\product.patch.dat port\  >nul 2>nul
if exist %tmp%\product.transfer.list move /y %tmp%\product.transfer.list port\  >nul 2>nul

if exist port\system (
echo -   Unpack finish  
echo.
%busybox% sh ./bin/windows/utility.sh rom-detail
%busybox% sh ./bin/windows/utility.sh rom-detail >> port/rom-detail
echo.
)
rem if exist port rd /s /q bin\tmp
set /p number=* go to main menu (press 1): 
if "%number%"=="1" goto main_menu
if not "%number%"=="1" goto main_menu 

:unpacksuper
cls
echo.
echo   Unpacking Super started... 
echo.
echo -------------------------------------------->> log.txt
echo      Unpacking and repacking v1.0         >> log.txt
echo           By %authors%            >> log.txt
echo -------------------------------------------->> log.txt
if exist bin\tmp\super rd /s /q bin\tmp\super
if not exist bin\tmp\super mkdir bin\tmp\super
if exist super.img (
copy super.img bin\tmp\super
echo -   Unpack Super.img
%simg2img%  bin\tmp\super\super.img  bin\tmp\super\super.raw >nul 2>nul >> log.txt
set cd=%cd%
bin\windows\7z x bin\tmp\super\super.raw -o%cd%\bin\tmp\super  >nul 2>nul >> log.txt
del bin\tmp\super\super.raw
del bin\tmp\super\super.img
echo -   Unpack super finish
)
echo.
echo 1) open unpack super.img (press 1) 
echo 2) go to main menu (press 2) 
set /p number=* Select an option: 
if "%number%"=="1" explorer.exe "%cd%\bin\tmp\super"
if "%number%"=="2" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
pause
exit

:rebuild
cls
echo Repacking started...
echo.  
echo -------------------------------------------->> log.txt
echo      Unpacking and repacking v1.0         >> log.txt
echo           By %authors%            >> log.txt
echo -------------------------------------------->> log.txt
if exist port\system (
%busybox% sh bin/windows/utility.sh rom-detail
echo.
)
if exist port_rom.zip del port_rom.zip
if exist bin\tmp rd /s /q bin\tmp
mkdir bin\tmp

set /p systemsize=<"port\system_size.txt"
echo -   Repack system  
bin\windows\make_ext4fs -s -L / -T -3 -S port\system_file_contexts -C port\system_fs_config -l %systemsize%0 -a / bin\tmp\system.img port\system\ >nul >> log.txt


echo -   Repack vendor 
set /p vendorsize=<"port\vendor_size.txt"
bin\windows\make_ext4fs -s -L vendor -T -3 -S port\vendor_file_contexts -C port\vendor_fs_config -l %vendorsize%0 -a vendor bin\tmp\vendor.img port\vendor\ >nul  >> log.txt

rem echo -   Repack product 
rem set /p productsize=<"port\product_size.txt"
rem bin\windows\make_ext4fs -s -L product -T -1 -S port\product_file_contexts -C port\product_fs_config -l %productsize% -a product bin\tmp\product.img port\product\ >nul


if exist bin\tmp\system.img (
echo -   Repack system.img
%img2sdat% bin\tmp\system.img -o bin\tmp -v 4  >nul 2>nul  >> log.txt
rem del bin\tmp\system.img
)

if exist bin\tmp\vendor.img (
echo -   Repack vendor.img 
%img2sdat% bin\tmp\vendor.img -o bin\tmp -v 4 -p vendor >nul 2>nul  >> log.txt
rem del bin\tmp\vendor.img
)

rem if exist bin\tmp\product.img (
rem echo -   Repack vendor.img 
rem %img2sdat% bin\tmp\product.img -o bin\tmp -v 4 -p product >nul 2>nul
rem del bin\tmp\vendor.img
rem )

if exist bin\tmp\system.new.dat (
echo -   Repack system.new.dat 
rem %brotli% --in bin\tmp\system.new.dat --out bin\tmp\system.new.dat.br --quality 6 --verbose 
%brotli% -3 -j -w 24 bin\tmp\system.new.dat >nul 2>nul  >> log.txt
)

if exist bin\tmp\vendor.new.dat (
echo -   Repack vendor.new.dat 
rem %brotli% --in bin\tmp\vendor.new.dat --out bin\tmp\vendor.new.dat.br --quality 6 --verbose 
%brotli% -3 -j -w 24 bin\tmp\vendor.new.dat >nul 2>nul  >> log.txt
)

rem if exist bin\tmp\product.new.dat (
rem echo -   Repack product.new.dat 
rem %brotli% -1 -j -w 24 bin\tmp\product.new.dat >nul
rem )

set tmp=bin\tmp
if exist port\boot.img copy /y port\boot.img %tmp%\ >nul 2>nul
if exist port\odm.img copy /y port\odm.img %tmp%\ >nul 2>nul
if exist port\compatibility.zip copy /y port\compatibility.zip %tmp% >nul
if exist port\compatibility_no_nfc.zip copy /y port\compatibility_no_nfc.zip %tmp% >nul
if exist port\dynamic_partitions_op_list copy /y port\dynamic_partitions_op_list %tmp% >nul 2>nul
if exist port\install xcopy /i /e /y port\install %tmp%\install >nul 2>nul
if exist port\firmware-update xcopy /i /e port\firmware-update %tmp%\firmware-update >nul 2>nul
if exist port\META-INF xcopy /i /e /y port\META-INF %tmp%\META-INF >nul 2>nul
if exist port\system2 xcopy /i /e /y port\system2 %tmp%\system >nul 2>nul
if exist port\product.new.dat.br copy /y port\product.new.dat.br %tmp% >nul 2>nul
if exist port\product.patch.dat copy /y port\product.patch.dat %tmp% >nul 2>nul
if exist port\product.transfer.list copy /y port\product.transfer.list %tmp% >nul 2>nul

if exist bin\tmp\META-INF (
echo -   Repack zip...
if exist bin\windows\sample.zip copy /y bin\windows\sample.zip >nul 2>nul  >> log.txt
bin\windows\7z a -tzip sample.zip ./bin/tmp/*  >nul 2>nul  >> log.txt
)
rename sample.zip port_rom.zip
if exist port_rom.zip echo -   finished!!
rem if exist port_rom.zip rd /s /q bin\tmp
set /p number=* go to main menu (press 1): 
if "%number%"=="1" goto main_menu
if not "%number%"=="1" goto main_menu 

:Exit
exit
:resize
cls
if not exist port (
echo No port found 
 )
echo Rom Status:
echo ------------------------------------------------
echo  System Size: %systemsize%                    
echo  vendor size: %vendorsize%                    
echo ------------------------------------------------
echo.
set /p changesystemsize=* Change system image size to: 
if exist port\system_size.txt del port\system_size.txt >nul
set /p changevendorsize=* Change vendor image size to: 
if exist port\vendor_size.txt del port\vendor_size.txt >nul
echo %changesystemsize% >> port\system_size.txt
set /p systemsize=<"port\system_size.txt"
echo %changevendorsize% >> port\vendor_size.txt
set /p vendorsize=<"port\vendor_size.txt"
echo Successfully changed 
set /p number=* go to main menu (press 1): 
if "%number%"=="1" goto main_menu
if not "%number%"=="1" goto main_menu 

:removeverity
cls
echo.
%verity% port\boot.img >nul 2>nul
if exist %system_root%\recovery-from-boot.p del %system_root%\system\recovery-from-boot.p > nul
if exist %vendor_root%\default.prop %sfk% replace %vendor_root%\default.prop "/secure=0/secure=1/" -yes > nul
if exist %vendor_root%\etc\fstab.qcom %sfk% replace %vendor_root%\etc\fstab.qcom "/,verify//" -yes > nul
if exist %vendor_root%\etc\fstab.qcom %sfk% replace %vendor_root%\etc\fstab.qcom "/forceencrypt=/encryptable=/" -yes > nul
if exist %vendor_root%\etc\fstab.qcom %sfk% replace %vendor_root%\etc\fstab.qcom "/forcefdeorfbe=/encryptable=/" -yes > nul
if exist %vendor_root%\etc\fstab.qcom %sfk% replace %vendor_root%\etc\fstab.qcom "/fileencryption=/encryptable=/" -yes > nul
if exist %vendor_root%\etc\fstab.qcom %sfk% replace %vendor_root%\etc\fstab.qcom "/.dmverity=true/.dmverity=false/" -yes > nul
echo  DM Verity removed!
set /p number=* go to main menu (press 1): 
if "%number%"=="1" goto main_menu
if not "%number%"=="1" goto main_menu 


:signzip
cls
echo Sign started... 
echo.
set pwd=%cd%
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta %dialog%') do set "file=%%p" 
set fn=%file:~0,-4%
java -jar bin\windows\signapk.jar bin\windows\test.certificate.x509.pem bin\windows\test.key.pk8 %file% %fn%-sign.zip
echo signin done!
echo.
echo 1) open sign zip (press 1) 
echo 2) go to main menu (press 2) 
set /p number=* Select an option: 
if "%number%"=="1" explorer.exe "%fn%-sign.zip"
if "%number%"=="2" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
pause
exit

:decompileapk
cls
if exist bin\apk rd /s /q bin\apk
if not exist bin\apk mkdir bin\apk
if exist *.apk copy /y *.apk bin\apk >nul 2>nul
if exist %cd%\bin\windows\apktool.jar copy /y %cd%\bin\windows\apktool.jar %cd%\bin\apk >nul 2>nul
rem for /r bin\apk %%f in (*.apk) do (
rem echo  -- %%~nxf detected --
rem set fname=%%~nxf
rem )
setlocal EnableDelayedExpansion
set i=0
for %%a in (*.apk*) do (
   set /A i+=1
   set list[!i!]=%%a
)
set Filesx=%i%
echo ------------------------------------------------
for /L %%i in (1,1,%Filesx%) do echo    %%i: !list[%%i]!
echo ------------------------------------------------
set /p input= * Choose file to decompile: 
echo.
echo Decompiling !list[%input%]! started... 
cd bin\apk
apktool.jar d -f !list[%input%]! 
echo.
echo successfully decompile!
echo.
echo 1) open decompile folder (press 1) 
echo 2) go to main menu (press 2) 
echo.
cd ..
cd ..
set /p number=* Select an option: 
if "%number%"=="1" explorer.exe "%cd%\bin\apk"
if "%number%"=="2" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu
pause
exit

:recompileapk
cls
echo.
set blank=
set /p fname=* Enter app directory name:%blank%
echo.
echo - recompiling %fname% started... 
cd bin\apk\
apktool.jar b -f %fname% 
cd ..
if exist %cd%\windows\signapk.jar copy /y %cd%\windows\signapk.jar %cd%\apk >nul 2>nul
if exist %cd%\windows\testkey.x509.pem copy /y %cd%\windows\testkey.x509.pem %cd%\apk >nul 2>nul
if exist %cd%\windows\testkey.pk8 copy /y %cd%\windows\testkey.pk8 %cd%\apk >nul 2>nul
java -jar apk\signapk.jar apk\test.certificate.x509.pem apk\test.key.pk8 apk\%fname%\dist\%fname%.apk apk\%fname%\dist\%fname%-sign.apk 
del %cd%\apk\signapk.jar
del %cd%\apk\testkey.x509.pem
del %cd%\apk\testkey.pk8
echo - successfully decompile 
echo.
echo 1) open decompile folder (press 1) 
echo 2) go to main menu (press 2) 
echo.
cd ..
set /p number=* Select an option: 
if "%number%"=="1" explorer.exe "%cd%\bin\apk\%fname%\dist"
if "%number%"=="2" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu
pause
exit

:unpack_system_and_repack
cls
if not exist bin\tmp\system mkdir bin\tmp\system
echo 1) Unpack system
echo 2) Repack system
echo 3) convert system.img to system.new.dat.br
echo 4) convert system.new.dat.br to system.img
echo 5) go back
set /p number=* Select an option: 
if "%number%"=="1" goto unpack_system
if "%number%"=="2" goto repack_system
if "%number%"=="3" goto img2br
if "%number%"=="4" goto br2img
if "%number%"=="5" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu


:unpack_system
cls
rem if exist bin\tmp\system rd /s /q bin\tmp\system
if exist system.img (
rem copy system.img bin\tmp\system
echo -   Unpack system.img 
rem %python% %imgextractorpy% bin\tmp\system.img bin\tmp\system\system >nul 2>nul  >> log.txt
%imgextractor% bin\tmp\system.img bin\tmp\system\system >nul 2>nul  >> log.txt
echo -   Successfully unpack system
rem del bin\tmp\system\system.img
)
echo 1) open system folder
echo 2) Go back 
set /p number=* Select an option: 
if "%number%"=="1"  explorer.exe "%cd%\bin\tmp\system\system"
if "%number%"=="2" goto unpack_system_and_repack
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu
pause

:repack_system
cls
set /p systemsize=<"bin\tmp\system\system_size.txt"
echo -   Repack system  
rem bin\windows\make_ext4fs -L system -T -6 -S bin\tmp\system_file_contexts -C bin\tmp\system_fs_config -l %systemsize%0 -a system  bin\tmp\system.img bin\tmp\system\system  >nul >> log.txt
bin\windows\make_ext4fs -s -L system -T -6 -S bin\tmp\system_file_contexts -C bin\tmp\system_fs_config -l %systemsize%0 -a system bin\tmp\system.img bin\tmp\system\system >nul >> log.txt
rem bin\windows\resize2fs -M bin\tmp\system.img >nul 2>nul  >> log.txt
echo -   Successfully repack system
echo 1) open system folder
echo 2) Go back 
set /p number=* Select an option: 
if "%number%"=="1"  explorer.exe "%cd%\bin\tmp\system\system"
if "%number%"=="2" goto unpack_system_and_repack
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu
pause

:img2br
cls
rem if exist bin\tmp\system rd /s /q bin\tmp\system
if not exist bin\tmp\system mkdir bin\tmp\system
if exist system.img (
rem copy system.img bin\tmp
echo -   convert system.img to system.new.dat
rem %python% %img2sdatpy% bin\tmp\system_s.img -o %cd%\system -v 4
%img2sdat% bin\tmp\system.img -o bin\tmp\system -v 4 >nul 2>nul  >> log.txt
rem del bin\tmp\system.img
rem del bin\tmp\system_s.img
)
if exist bin\tmp\system\system.new.dat (
echo -   convert system.new.dat to system.new.dat.br 
rem %brotli% --in bin\tmp\system.new.dat --out bin\tmp\system.new.dat.br --quality 6 --verbose 
%brotli% -3 -j -w 24 bin\tmp\system\system.new.dat >nul 2>nul  >> log.txt
echo -   Finish
)
echo 1) open converted .br folder
echo 2) Go back 
set /p number=* Select an option: 
if "%number%"=="1"  explorer.exe "%cd%\bin\tmp\system"
if "%number%"=="2" goto unpack_system_and_repack
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu
pause


:unpack_vendor
if exist system_unpack&repack rd /s /q system_unpack&repack
if not exist system_unpack&repack mkdir system_unpack&repack 
if exist vendor.img (
echo -   Unpack vendor.img 
%imgextractor% vendor.img system_unpack&repack\vendor >nul 2>nul  >> log.txt
echo -   Successfully unpack system
del bin\tmp\vendor.img
echo 1) open vendor folder
echo 2) Go back 
set /p number=* Select an option: 
if "%number%"=="1" goto unpack_system
if "%number%"=="2" goto unpack_system_and_repack
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu
)

:payload_extract
cls
if exist bin\tmp\payload\ rd /s /q bin\tmp\payload\
if not exist bin\tmp\payload mkdir bin\tmp\payload 
set payloaddir=%cd%
echo 1) Install dependency (recommended)
echo 2) Extract payload.bin 
set /p number=* Select an option: 
if "%number%"=="1" goto payload_dependancy
if "%number%"=="2" goto payload_unpack_py
if "%number%"=="3" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu


:payload_dependancy
cls
echo -   installing dependency
cd bin\windows\payload_dumper  
python -m pip install -r requirements.txt
echo -   install dependency successfully
pause
goto payload_extract


:payload_unpack
if exist bin\tmp\payload rd /s /q bin\tmp\payload
if not exist bin\tmp\payload mkdir bin\tmp\payload 
rem if exist payload.bin (
rem copy payload.bin bin\tmp\payload
echo -   Unpacking Payload.bin
%payload% bin\tmp\payload\payload.bin --out bin\tmp\payload >nul 2>nul  >> log.txt
echo -   Successfully Unpack Payload.bin
rem del bin\tmp\payload\payload.bin
rem )
echo 1) open payload folder
echo 2) Go back 
set /p number=* Select an option: 
if "%number%"=="1" explorer.exe "%cd%\bin\tmp\payload"
if "%number%"=="2" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu

:payload_unpack_py
set payload_dir=%c%\bin\tmp\payload  
if exist payload.bin (
cd bin\windows\payload_dumper
rem copy payload.bin bin\tmp\payload
echo.
echo -   Unpacking Payload.bin
echo.
python payload_dumper.py %payloaddir%\payload.bin
cd output
move * %payloaddir%\bin\tmp\payload >nul 2>nul 
echo.
echo -   Successfully unpack Payload.bin
rem del bin\tmp\payload\payload.bin
)
cd %payloaddir%
echo 1) open payload folder
echo 2) Go back 
set /p number=* Select an option: 
if "%number%"=="1" explorer.exe "%payloaddir%\bin\tmp\payload"
if "%number%"=="2" goto main_menu
if not "%number%"=="1" if not "%number%"=="2"
goto main_menu


:clean
echo Cleaning started...
echo.   
if exist port rd /s /q port
echo -   Removing port folder   
if exist bin\tmp rd /s /q bin\tmp
echo -   Removing tmp folder 
if exist port_rom.zip del port_rom.zip
echo -   Removing port_rom.zip  
echo - Done
echo.
set /p number=* go to main menu (press 1): 
if "%number%"=="1" goto main_menu
if not "%number%"=="1" goto main_menu 
pause
