@call build-vars.bat

@echo build qhull start...
set SRCDIR=../qhull-2012.1

@if "%1"=="release" (
	@call :BuildqhullReleaseVer
)
@if "%1"=="debug" (
	@call :BuildqhullDebugVer
)

@goto end

@REM -----------------------------------------------------------------------
:BuildqhullReleaseVer
@mkdir build-qhull-cmake.release
cd build-qhull-cmake.release
cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\qhull" -DCMAKE_BUILD_TYPE=Release
@jom.exe
@jom.exe install
@echo build and install finished
 
@cd ..
@rmdir /s/q build-qhull-cmake.release
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildqhullDebugVer
@mkdir build-qhull-cmake.debug
@cd build-qhull-cmake.debug

@cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\qhull" -DCMAKE_BUILD_TYPE=Debug
@jom.exe
@jom.exe install
@echo build.debug and install finished
 
@cd ..
@rmdir /s/q build-qhull-cmake.debug
@exit /B 0

@echo build qhull end...

:end