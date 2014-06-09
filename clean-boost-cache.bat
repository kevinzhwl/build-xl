
@set SRCDIR=%~dp0

@echo clean boost math build cache ...
@call :RemoveLibMathCache
@echo clean finished

@goto end

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