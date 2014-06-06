@echo build all pcl 3rdparty dependecies
@echo build all by cmake

@call build-flann.bat release
@call build-qhull.bat release
@call build-eigen.bat release
@call build-boost.bat release
@call build-vtk.bat release

@echo build all(cmake) finished