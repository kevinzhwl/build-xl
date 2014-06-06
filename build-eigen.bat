@call build-vars.bat

@echo build eigen start...
set SRCDIR=../eigen-3.0.7

@if "%1"=="release" (
	@call :BuildEigenReleaseVer
)
@if "%1"=="debug" (
	@call :BuildEigenDebugVer
)

@goto end

@REM -----------------------------------------------------------------------
:BuildEigenReleaseVer
@mkdir build-eigen-cmake.release
cd build-eigen-cmake.release
cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\eigen" -DCMAKE_BUILD_TYPE=Release
@jom.exe
@jom.exe install
@echo build and install finished
 
@cd ..
@rmdir /s/q build-eigen-cmake.release
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildEigenDebugVer
@mkdir build-eigen-cmake.debug
@cd build-eigen-cmake.debug

@cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\eigen" -DCMAKE_BUILD_TYPE=Debug
@jom.exe
@jom.exe install
@echo build.debug and install finished
 
@cd ..
@rmdir /s/q build-eigen-cmake.debug
@exit /B 0

@echo build eigen end...

:end