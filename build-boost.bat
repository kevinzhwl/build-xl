@call build-vars.bat

@echo build boost start...
@if "%XL_BUILD_BATCHALL%" == "" (
@set XL_BOOST_DIR=%~dp0boost-cmake-mp.wc
@set XL_DEPLOY_BOOST_DIR=%~dp0deploy\3rd\boost

)

@if "%XL_DEPLOY_BOOST_DIR%" =="" (
    @echo XL_DEPLOY_BOOST_DIR is empty
    @goto end
)

@if not exist "%XL_BOOST_DIR%" (
    @echo XL_BOOST_DIR is not existed
    @goto end
)

@set SRCDIR=%XL_BOOST_DIR%
@set CL_PARAM=-DMSVC90=1 -DCMAKE_MAKE_PROGRAM:PATH="%VCINSTALLDIR%\bin\nmake.exe" 
@set INS_PARAM=-DCMAKE_INSTALL_PREFIX:PATH="%XL_DEPLOY_BOOST_DIR%"
@set CBD_PARAM=-DCMAKE_BUILD_TYPE=Release
@set BD_PARAM=-DLIBPREFIX=lib

@call :RemoveLibMathCache

@if "%1"=="" (
	@set BD_DIR=build-boost-cmake.release
	@set MD_PARAM=-DENABLE_STATIC_RUNTIME:BOOL=OFF
	@call :BuildJob
	@call :RemoveLibMathCache
)

@if "%1"=="release" (
	@set BD_DIR=build-boost-cmake.release
	@set MD_PARAM=-DENABLE_DEBUG:BOOL=OFF
	@call :BuildJob
	@call :RemoveLibMathCache
)
@if "%1"=="debug" (
	@set BD_DIR=build-boost-cmake.debug
	@set MD_PARAM=-DENABLE_RELEASE:BOOL=OFF
	@call :BuildJob
	@call :RemoveLibMathCache
)
@if "%1"=="relmini" (
	@set BD_DIR=build-boost-cmake.relmini
	@set MD_PARAM=-DENABLE_DEBUG:BOOL=OFF -DENABLE_SHARED:BOOL=OFF -DENABLE_STATIC_RUNTIME:BOOL=OFF
	@call :BuildJob
	@call :RemoveLibMathCache
)
@if "%1"=="debmini" (
	@set BD_DIR=build-boost-cmake.debmini
	@set MD_PARAM=-DENABLE_RELEASE:BOOL=OFF -DENABLE_SHARED:BOOL=OFF -DENABLE_STATIC_RUNTIME:BOOL=OFF
	@call :BuildJob
	@call :RemoveLibMathCache
)

@echo build boost end...
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
:RemoveLibMathCache
@del %SRCDIR%\libs\math\config\CMakeCache.txt
@del %SRCDIR%\libs\math\config\Makefile
@del %SRCDIR%\libs\math\config\cmake_install.cmake
@rmdir /s/q %SRCDIR%\libs\math\config\CMakeFiles

@del %SRCDIR%\libs\math\config\has_long_double_support.exe.embed.manifest
@del %SRCDIR%\libs\math\config\has_long_double_support.exe.resource.txt
@del %SRCDIR%\libs\math\config\has_long_double_support.exe.embed.manifest.res
@del %SRCDIR%\libs\math\config\has_long_double_support.exe.intermediate.manifest
@del %SRCDIR%\libs\math\config\has_long_double_support.pdb

@exit /B 0

@REM -----------------------------------------------------------------------
:end