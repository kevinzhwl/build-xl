@echo build all pcl-3rdparty dependecies
@echo build boost by bjam

@call build-flann.bat release
@call build-qhull.bat release
@call build-eigen.bat release
@call build-b2-boost.bat release
@call build-vtk.bat release

@echo build all(cmake+bjam) finished