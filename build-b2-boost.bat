
@echo build boost by bjam start...

@set SRCDIR=boost-cmake-1.49.0
@set LYTDIR=boost-1_49
@set TOOLCHAIN=toolset=msvc-9.0 architecture=x86 address-model=64
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" 
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%~dp0deploy\boost"
@set CBD_PARAM=--without-python --without-mpi
@set BD_PARAM=install --prefix="%~dp0deploy\boost" --build-type=complete --build-dir="%~dp0%BD_DIR%"

@if "%1"=="" (
	@call :BuildBjam
	@set BD_DIR=build-boost-bjam.release
	@set MD_PARAM=-DENABLE_STATIC_RUNTIME:BOOL=OFF
	@call :BuildboostReleaseVer
	@call :RemoveDirLayout
)

@if "%1"=="release" (
	@call :BuildBjam
	@set BD_DIR=build-boost-bjam.release
	@set MD_PARAM=-DENABLE_DEBUG:BOOL=OFF
	@call :BuildboostReleaseVer
	@call :RemoveDirLayout
)

@if "%1"=="debug" (
	@call :BuildBjam
	@set BD_DIR=build-boost-bjam.debug
	@set MD_PARAM=-DENABLE_RELEASE:BOOL=OFF
	@call :BuildboostDebugVer
	@call :RemoveDirLayout
	)

@echo build boost end...
@goto end

@REM -----------------------------------------------------------------------
:BuildBjam
@cd %SRCDIR%
@if not exist "b2.exe" (
	call bootstrap.bat
)
@cd ..
@exit /B 0

@REM -----------------------------------------------------------------------
:RemoveDirLayout
@cd %~dp0deploy\boost
@cd include
@xcopy %LYTDIR%\*.* .\ /E/Y
@rmdir /s/q %LYTDIR%
@cd ..
@cd %~dp0
@exit /B 0


@REM -----------------------------------------------------------------------
:BuildboostDebugVer
@rmdir /s/q %BD_DIR%
@mkdir %BD_DIR%
@cd %SRCDIR%

@if exist "b2.exe" (
	b2.exe install %BD_PARAM% %CBD_PARAM% %TOOLCHAIN%
	)

@cd ..
@rmdir /s/q %BD_DIR%
@exit /B 0


@REM -----------------------------------------------------------------------
:end