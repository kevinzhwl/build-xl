
@call build-vars.bat

@echo build pcl start...

@if "%XL_DEPLOY_PCL_DIR%" =="" (
    @echo XL_DEPLOY_PCL_DIR is empty
    @goto end
)

@if not exist "%XL_DEPT_DIR%" (
    @echo XL_DEPT_DIR is not existed
    @goto end
)

@if not exist "%XL_PCL_DIR%" (
    @echo XL_PCL_DIR is not existed
    @goto end
)

@set SRCDIR=%XL_PCL_DIR%
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" 
@set BD_PARAM=-DSEG_THIRDPARTY_ROOT_DIR="%XL_DEPT_DIR%"
@set DP_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%XL_DEPLOY_PCL_DIR%"
@set PCL_PARAM=-DPCL_SHARED_LIBS=ON

@if "%1"=="" (
	@echo building pcl release version
	@set BD_DIR=build-pcl-cmake.release
	@set BT_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :Buildpcl
	@goto end
)

@if "%1"=="release" (
	@echo building pcl release version
	@set BD_DIR=build-pcl-cmake.release
	@set BT_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :Buildpcl
)
@if "%2"=="debug" (
	@echo building pcl debug version
	@set BD_DIR=build-pcl-cmake.debug
	@set BT_PARAM=-DCMAKE_BUILD_TYPE=Debug
	@call :Buildpcl
)

@echo build and install finished
@goto end

@REM -----------------------------------------------------------------------
:Buildpcl
@rmdir /s/q %BD_DIR%
@mkdir %BD_DIR%
@cd %BD_DIR%
@cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %PCL_PARAM% %DP_PARAM% %BD_PARAM% %BT_PARAM%
@cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %PCL_PARAM% %DP_PARAM% %BD_PARAM% %BT_PARAM%
@jom.exe
@jom.exe install
 
@cd ..
@rmdir /s/q %BD_DIR%
@exit /B 0

@REM -----------------------------------------------------------------------
:end