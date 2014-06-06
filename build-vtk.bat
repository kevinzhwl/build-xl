@call build-vars.bat

@REM set PATH=%PATH%;%VCINSTALLDIR%\redist\Debug_NonRedist\amd64\Microsoft.VC90.DebugCRT
@echo build vtk start...
@set SRCDIR=../VTK-5.8.0
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe"
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\vtk"
@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
@set BD_PARAM=
@set MD_PARAM=-DBUILD_TESTING:BOOL=OFF

@if "%1"=="release" (
	@set BD_DIR=build-vtk-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :BuildJob
)

@if "%1"=="debug" (
	@set BD_DIR=build-vtk-cmake.debug
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Debug -DCMAKE_DEBUG_POSTFIX="-gd" -D_BIND_TO_CURRENT_VCLIBS_VERSION=1
	@call :BuildJob
)

@echo build vtk end...
@goto end

@REM -----------------------------------------------------------------------
:BuildJob
@rmdir /s/q %BD_DIR%
@mkdir %BD_DIR%
@cd %BD_DIR%

@cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %INS_PARAM% %CBD_PARAM% %BD_PARAM% %MD_PARAM%
@jom.exe
@jom.exe install
 
@cd ..
@rmdir /s/q %BD_DIR%
@exit /B 0

@REM -----------------------------------------------------------------------
:end