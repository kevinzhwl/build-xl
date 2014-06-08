@echo build all pcl 3rdparty dependecies
@echo build all by cmake

@set XL_FLANN_DIR=%~dp0flann-1.7.1
@set XL_QHULL_DIR=%~dp0qhull-6.2.0.1385
@set XL_EIGEN_DIR=%~dp0eigen-3.0.7
@set XL_BOOST_DIR=%~dp0boost-cmake-1.49.0
@set XL_VTK_DIR=%~dp0VTK-5.8.0
@set XL_PCL_DIR=%~dp0pcl-1.6.0
@set XL_DEPT_DIR=%~dp0deploy
@set XL_DEPLOY_FLANN_DIR=%~dp0deploy\flann
@set XL_DEPLOY_QHULL_DIR=%~dp0deploy\qhull
@set XL_DEPLOY_EIGEN_DIR=%~dp0deploy\eigen
@set XL_DEPLOY_BOOST_DIR=%~dp0deploy\boost
@set XL_DEPLOY_VTK_DIR=%~dp0deploy\vtk
@set XL_DEPLOY_PCL_DIR=%~dp0deploy\pcl


@if "%1"=="" (
	@call build-flann.bat release
	@call build-qhull.bat debug
	@call build-qhull.bat release
	@call build-eigen.bat release
	@call build-boost.bat 
	@REM call build-vtk.bat debug
	@call build-vtk.bat release
)

@if "%1"=="release" (
	@call build-flann.bat release
	@call build-qhull.bat release
	@call build-eigen.bat release
	@call build-boost.bat release
	@call build-vtk.bat release
)
@if "%1"=="relmini" (
	@call build-flann.bat release
	@call build-qhull.bat release
	@call build-eigen.bat release
	@call build-boost.bat relmini
	@call build-vtk.bat relmini
)
@if "%2"=="debug" (
	@call build-flann.bat debug
	@call build-qhull.bat debug
	@call build-eigen.bat debug
	@call build-boost.bat debug
	@call build-vtk.bat debug
)
@if "%2"=="debmini" (
	@call build-flann.bat debug
	@call build-qhull.bat debug
	@call build-eigen.bat debug
	@call build-boost.bat debmini
	@call build-vtk.bat debmini
)


@set XL_FLANN_DIR=
@set XL_QHULL_DIR=
@set XL_EIGEN_DIR=
@set XL_BOOST_DIR=
@set XL_VTK_DIR=
@set XL_PCL_DIR=
@set XL_DEPT_DIR=
@set XL_DEPLOY_FLANN_DIR=
@set XL_DEPLOY_QHULL_DIR=
@set XL_DEPLOY_EIGEN_DIR=
@set XL_DEPLOY_BOOST_DIR=
@set XL_DEPLOY_VTK_DIR=
@set XL_DEPLOY_PCL_DIR=

@goto end

:end
@echo build all(cmake) finished