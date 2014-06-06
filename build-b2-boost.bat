
@echo build boost by bjam start...
set BOOST_SRCDIR = boost-cmake-1.49.0
set SRCDIR=boost-cmake-1.49.0
set LYTDIR=boost-1_49
set TOOLCHAIN=toolset=msvc-9.0 architecture=x86 address-model=64

@if "%1"=="release" (
	@call :BuildBjam
	@call :BuildboostReleaseVer
	@call :RemoveDirLayout
)
@if "%1"=="debug" (
	@call :BuildboostDebugVer
)

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
:BuildboostReleaseVer
@rmdir /s/q build-boost-bjam.release
@mkdir build-boost-bjam.release

@cd %SRCDIR%
@if exist "b2.exe" (
	b2.exe install --prefix="%~dp0deploy\boost" --build-type=complete --build-dir="%~dp0build-boost-bjam.release" --without-python --without-mpi %TOOLCHAIN%
	)
@cd ..

@REM rmdir /s/q build-boost-bjam.release
@exit /B 0

@REM -----------------------------------------------------------------------
:BuildboostDebugVer
@rmdir /s/q build-boost-bjam.debug
@mkdir build-boost-bjam.debug

@cd %SRCDIR%
@if exist "b2.exe" (
	b2.exe install --prefix="%~dp0deploy\boost" --build-type=complete --build-dir="%~dp0build-boost-bjam.release" --without-python --without-mpi %TOOLCHAIN%
	)
@cd ..

@REM rmdir /s/q build-boost-bjam.debug
@exit /B 0

@echo build boost end...

:end