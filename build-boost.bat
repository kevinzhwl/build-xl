@call build-vars.bat

@echo build boost start...
set BOOST_SRCDIR = boost-cmake-1.49.0
set SRCDIR=../boost-cmake-1.49.0

@if "%1"=="release" (
	@call :BuildboostReleaseVer
)
@if "%1"=="debug" (
	@call :BuildboostDebugVer
)

@goto end

@REM -----------------------------------------------------------------------
:BuildboostReleaseVer
@rmdir /s/q build-boost-cmake.release
@mkdir build-boost-cmake.release
cd build-boost-cmake.release
cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\boost" -DCMAKE_BUILD_TYPE=Release -DLIBPREFIX=lib
@jom.exe
@jom.exe install
@echo build and install finished
 
@cd ..
@rmdir /s/q build-boost-cmake.release
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildboostDebugVer
@mkdir build-boost-cmake.debug
@cd build-boost-cmake.debug

@cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\boost" -DCMAKE_BUILD_TYPE=Debug -DLIBPREFIX=lib
@jom.exe
@jom.exe install
@echo build.debug and install finished
 
@cd ..
@rmdir /s/q build-boost-cmake.debug
@exit /B 0

@echo build boost end...

:end