@echo off
SETLOCAL ENABLEEXTENSIONS

rem Remove build directory
IF EXIST build RMDIR /S /Q build || goto :error
MD build || goto :error

cd OpenSSL

echo "Setting up build for Windows UWP.."
perl Configure no-asm no-hw no-dso VC-WINUNIVERSAL || goto :error
call ms\do_winuniversal.bat || goto :error

FOR %%P IN (win32,x64,arm) DO (
  echo "Building OpenSSL as Windows10/%%P"
  call ms\setVSvars universal10.0%%P || goto :error
  rem clean up temporary files
  IF EXIST tmp32 call nmake -f ms\nt.mak clean
  rem do build
  call nmake -f ms\nt.mak || goto :error
  MD ..\build\libs\uwp\%%P || goto :error
  COPY out32\libeay32.lib ..\build\libs\uwp\%%P || goto :error)

rem copy header files
MD ..\build\include || goto :error
COPY inc32\openssl\*.h ..\build\include\ || goto :error

echo "Setting up build for Windows 8.1.."
perl Configure no-asm no-hw no-dso VC-WINSTORE || goto :error
call ms\do_winstore.bat || goto :error
setLocal EnableDelayedExpansion
FOR %%P IN (win32,x64,arm) DO (
  echo "Building OpenSSL as Windows8.1/%%P"
  call ms\setVSvars ws8.1%%P || goto :error
  rem code below is required to fix Platform.winmd has not been found error
  SET LIBPATH=!LIBPATH!;!ExtensionSdkDir!\Microsoft.VCLibs\12.0\References\CommonConfiguration\neutral
  rem clean up temporary files
  IF EXIST tmp32 call nmake -f ms\nt.mak clean
  rem do build
  call nmake -f ms\nt.mak || goto :error
  MD ..\build\libs\win81\%%P || goto :error
  COPY out32\libeay32.lib ..\build\libs\win81\%%P || goto :error)

echo "Build completed; results could be found in './build' folder"
exit /b 0

:error
echo Script failed with error #%errorlevel%.
echo "Please refer to the following instruction for extra help with OpenSSL build on Windows: https://github.com/Microsoft/openssl/blob/OpenSSL_1_0_2_WinRT-stable/INSTALL.WINUNIVERSAL"
exit /b %errorlevel%
