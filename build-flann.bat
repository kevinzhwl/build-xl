@call build-vars.bat

@echo build flann start...

@set SRCDIR=../flann-1.7.1
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" 
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\flann"
@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
@set BD_PARAM=-DFLANN_LIB_INSTALL_DIR="lib"
@set MD_PARAM=-DBUILD_MATLAB_BINDINGS:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=OFF

@if "%1"=="" (
	@set BD_DIR=build-flann-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :BuildJob
)
@if "%1"=="release" (
	@set BD_DIR=build-flann-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :BuildJob
)
@if "%1"=="debug" (
	@set BD_DIR=build-flann-cmake.debug
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=debug
	@call :BuildJob
)

@echo build flann end...
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
