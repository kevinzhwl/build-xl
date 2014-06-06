@call build-vars.bat

@echo build flann start...

@if "%1"=="release" (
	@call :BuildFlannReleaseVer
)
@if "%1"=="debug" (
	@call :BuildFlannDebugVer
)

@goto end

@REM -----------------------------------------------------------------------
:BuildFlannReleaseVer
@mkdir build-flann-cmake.release
@cd build-flann-cmake.release
@cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" ../flann-1.7.1 -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy/flann/" -DCMAKE_BUILD_TYPE=Release
@jom.exe
@jom.exe install
@echo build and install finished
 
@cd ..
@rmdir /s/q build-flann-cmake.release
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildFlannDebugVer
@mkdir build-flann-cmake.debug
@cd build-flann-cmake.debug

@cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" ../flann-1.7.1 -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy/flann/" -DCMAKE_BUILD_TYPE=Debug
@jom.exe
@jom.exe install
@echo build.debug and install finished
 
@cd ..
@rmdir /s/q build-flann-cmake.debug
@exit /B 0

@echo build flann end...

:end