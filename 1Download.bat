@ECHO OFF
SETLOCAL EnableDelayedExpansion 

CALL "%VS120COMNTOOLS%\vsvars32.bat"

set THIS=%CD%
set DOWNLOAD=%CD%\download
set TOOLS=%CD%\tools
set SRC=%CD%\src
set WGET=%TOOLS%\wget.exe
set UNTAR=%TOOLS%\tar.exe -zxvf
set SERVER_PATH=Public/xr-libs
set SERVER_HOSTNAME=ftp://xordi.noip.me
set WGET_FAILMSG=
set LF=^



IF %PROCESSOR_ARCHITECTURE%=="IA64" OR IF %PROCESSOR_ARCHITECTURE%=="AMD64" (
  SET WGET=%TOOLS%\wget64.exe
  )
echo ---WGET found in %WGET%---

IF NOT EXIST %DOWNLOAD% mkdir %DOWNLOAD%
ECHO --- Pobieranie listy plikรณw do pobrania ---
CALL %WGET% -nc -P %DOWNLOAD% %SERVER_HOSTNAME%/%SERVER_PATH%/list.txt

FOR /F "tokens=1 eol=;" %%G IN (%DOWNLOAD%\list.txt) DO (
	ECHO Checking for %%G....
	IF NOT EXIST %DOWNLOAD%\%%G (
	%WGET% -nc -P %DOWNLOAD% %SERVER_HOSTNAME%/%SERVER_PATH%/%%G
	echo %errorlevel%
	) ELSE (
		ECHO Already have %%G source tarball.
	)
	
	IF NOT EXIST %DOWNLOAD%\%%G (
		CALL :WGETFAIL %%G
	)
)
IF DEFINED WGET_FAILMSG goto :FAIL

echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Extracting...                                                 บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
cd %DOWNLOAD%

FOR /F "tokens=1 eol=;" %%G IN (list.txt) DO (
	%UNTAR% %%G
)















CALL :END



:WGETFAIL
SETLOCAL
set NEWMSG=Failed to download %1 source tarball.
ENDLOCAL & SET WGET_FAILMSG=!WGET_FAILMSG!บ %NEWMSG%!LF!
goto :eof

:FAIL
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo !WGET_FAILMSG!
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

:END

