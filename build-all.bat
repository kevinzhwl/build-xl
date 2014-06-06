@echo build all pcl 3rdparty dependecies
@echo build all by cmake

@if "%1"=="" (
	@call build-flann.bat release
	@call build-qhull.bat debug
	@call build-qhull.bat release
	@call build-eigen.bat release
	@call build-boost.bat 
	@call build-vtk.bat debug
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
	@call build-vtk.bat debmini
)
@if "%2"=="debmini" (
	@call build-flann.bat debug
	@call build-qhull.bat debug
	@call build-eigen.bat debug
	@call build-boost.bat debmini
	@call build-vtk.bat debmini
)
goto end

:end
@echo build all(cmake) finished