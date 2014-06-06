@call build-vars.bat

@echo build vtk start...
set SRCDIR=../VTK-5.8.0

@if "%1"=="release" (
	@call :BuildvtkReleaseVer
)
@if "%1"=="debug" (
	@call :BuildvtkDebugVer
)

@goto end

@REM -----------------------------------------------------------------------
:BuildvtkReleaseVer
@mkdir build-vtk-cmake.release
cd build-vtk-cmake.release
cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\vtk" -DCMAKE_BUILD_TYPE=Release
@jom.exe
@jom.exe install
@echo build and install finished
 
@cd ..
@rmdir /s/q build-vtk-cmake.release
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildvtkDebugVer
@mkdir build-vtk-cmake.debug
@cd build-vtk-cmake.debug

@cmake.exe -DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" "%SRCDIR%" -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\vtk" -DCMAKE_BUILD_TYPE=Debug
@jom.exe
@jom.exe install
@echo build.debug and install finished
 
@cd ..
@rmdir /s/q build-vtk-cmake.debug
@exit /B 0

@echo build vtk end...

:end