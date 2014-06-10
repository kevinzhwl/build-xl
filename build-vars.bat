@echo called after vcvarsall
@echo set cmake jom path environment

@if "%XL_CMDENV%" == "" (

@if "%CMAKEDIR%" =="" (
@SET CMAKEDIR=C:\qt\cmake-2.8.11.2-win32-x86\bin
)
@SET PATH=%CMAKEDIR%;%PATH%

@if "%JOMDIR%" =="" (
@SET JOMDIR=C:\qt\qtcreator\2.4.1\bin
@SET JOM3DIR=C:\qt\qtcreator\3.1.0\bin
)
@SET PATH=%JOMDIR%;%PATH%

)
@set XL_CMDENV="XL_CMDENV_SET"