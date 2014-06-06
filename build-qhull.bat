@call build-vars.bat

@echo build qhull start...

@set SRCDIR=../qhull-6.2.0.1385
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" 
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\qhull"
@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
@set BD_PARAM=
@set MD_PARAM=

@if "%1"=="" (
	@set BD_DIR=build-qhull-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :BuildJob
)
@if "%1"=="release" (
	@set BD_DIR=build-qhull-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :BuildJob
)
@if "%1"=="debug" (
	@set BD_DIR=build-qhull-cmake.debug
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Debug
	@call :BuildJob
)

@echo build qhull end...
@goto end

@REM -----------------------------------------------------------------------
:BuildJob
@rmdir /s/q %BD_DIR%
@mkdir %BD_DIR%
cd %BD_DIR%
cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %INS_PARAM% %CBD_PARAM% %BD_PARAM% %MD_PARAM%
@jom.exe
@jom.exe install
 
@cd ..
@rmdir /s/q %BD_DIR%
@exit /B 0

@REM -----------------------------------------------------------------------
:end
