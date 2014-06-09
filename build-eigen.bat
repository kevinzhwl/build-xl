@call build-vars.bat

@echo build eigen start...

@if "%XL_DEPLOY_EIGEN_DIR%" =="" (
    @echo XL_DEPLOY_EIGEN_DIR is empty
    @goto end
)

@if not exist "%XL_EIGEN_DIR%" (
    @echo XL_EIGEN_DIR is not existed
    @goto end
)

@set SRCDIR=%XL_EIGEN_DIR%
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" 
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%XL_DEPLOY_EIGEN_DIR%" -DEIGEN_INCLUDE_INSTALL_DIR:PATH="%XL_DEPLOY_EIGEN_DIR%\include"
@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
@set BD_PARAM=
@set MD_PARAM=

@if "%1"=="" (
	@set BD_DIR=build-eigen-cmake.release
	@call :BuildJob
)
@if "%1"=="release" (
	@set BD_DIR=build-eigen-cmake.release
	@call :BuildJob
)
@if "%1"=="debug" (
	@set BD_DIR=build-eigen-cmake.debug
	@call :BuildJob
)

@echo build eigen end...
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
