
@call build-vars.bat

@echo build pcl start...
@if "%XL_BUILD_BATCHALL%" == "" (
@set XL_PCL_DIR=%~dp0pcl.wc
@set XL_DEPT_DIR=%~dp0deploy\3rd
@set XL_DEPLOY_PCL_DIR=%~dp0deploy\pcl

)

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
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%XL_DEPLOY_PCL_DIR%"
@set BD_APA=-DBUILD_OPENNI=OFF -DBUILD_TESTS=OFF -DBUILD_apps=OFF -DBUILD_common=ON -DBUILD_features=OFF -DBUILD_examples=OFF -DBUILD_filters=OFF -DBUILD_geometry=OFF
@set BD_APB=-DBUILD_global_tests=OFF -DBUILD_io=ON -DBUILD_kdtree=OFF -DBUILD_keypoints=OFF -DBUILD_octree=ON -DBUILD_sample_consensus=OFF -DBUILD_registration=OFF
@set BD_APC=-DBUILD_search=OFF -DBUILD_segmentation=OFF -DBUILD_surface=OFF -DBUILD_tools=OFF -DBUILD_tracking=OFF -DBUILD_visualization=OFF

@set BD_PARAM=-DSEG_THIRDPARTY_ROOT_DIR="%XL_DEPT_DIR%" -DPCL_SHARED_LIBS=ON %BD_APA% %BD_APB% %BD_APC%
@set MD_PARAM=-DBOOST_ROOT="%XL_DEPT_DIR%\Boost" -DEIGEN_ROOT="%XL_DEPT_DIR%\Eigen" -DQHULL_ROOT="%XL_DEPT_DIR%\Qhull" -DVTK_DIR="%XL_DEPT_DIR%\VTK\lib\vtk-5.8" -DFLANN_ROOT="%XL_DEPT_DIR%\FLANN"


@if "%1"=="" (
	@echo building pcl release version
	@set BD_DIR=build-pcl-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :Buildpcl
	@goto end
)

@if "%2"=="debug" (
	@echo building pcl debug version
	@set BD_DIR=build-pcl-cmake.debug
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Debug
	@call :Buildpcl
)

@if "%1"=="release" (
	@echo building pcl release version
	@set BD_DIR=build-pcl-cmake.release
	@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
	@call :Buildpcl
)


@echo build and install finished
@goto end

@REM -----------------------------------------------------------------------
:Buildpcl
@rmdir /s/q %BD_DIR%
@mkdir %BD_DIR%
@cd %BD_DIR%
@cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %INS_PARAM% %CBD_PARAM% %BD_PARAM% %MD_PARAM%
@cmake.exe %CL_PARAM% "%SRCDIR%" -G "NMake Makefiles" %INS_PARAM% %CBD_PARAM% %BD_PARAM% %MD_PARAM%
@jom.exe
@jom.exe install
 
@cd ..
@rmdir /s/q %BD_DIR%
@exit /B 0

@REM -----------------------------------------------------------------------
:end