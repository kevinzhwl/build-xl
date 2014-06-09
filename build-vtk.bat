@call build-vars.bat

@echo build vtk start...

@if "%XL_DEPLOY_VTK_DIR%" =="" (
    @echo XL_DEPLOY_VTK_DIR is empty
    @goto end
)

@if not exist "%XL_VTK_DIR%" (
    @echo XL_VTK_DIR is not existed
    @goto end
)

@if "%2"=="" (
@set DEBCRT_DIR=%XL_WORKAROUND_DIR%\vc2008sp1redist\Debug_NonRedist\amd64\Microsoft.VC90.DebugCRT
)

@if "%2"=="32bit" (
@set DEBCRT_DIR=%XL_WORKAROUND_DIR%\vc2008sp1redist\Debug_NonRedist\x86\Microsoft.VC90.DebugCRT
)

@REM set PATH=%PATH%;%VCINSTALLDIR%\redist\Debug_NonRedist\amd64\Microsoft.VC90.DebugCRT
@set SRCDIR=%XL_VTK_DIR%
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe"
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%XL_DEPLOY_VTK_DIR%"
@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
@set BD_PARAM=-D_BIND_TO_CURRENT_VCLIBS_VERSION=1
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
@call :BuildWorkaround

@cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %INS_PARAM% %CBD_PARAM% %BD_PARAM% %MD_PARAM%
@jom.exe
@jom.exe install
 
@cd ..
@rmdir /s/q %BD_DIR%
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildWorkaround
if exist %DEBCRT_DIR% (
@xcopy %DEBCRT_DIR%\*.* .\bin\ /Y
)

@exit /B 0

@REM -----------------------------------------------------------------------
:end