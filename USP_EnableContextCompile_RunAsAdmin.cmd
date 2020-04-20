@echo off
cls
echo.
echo [------------------------------------------------------------------------]
echo [           Utility: Enable Compiling USP Files By Context Menu          ]
echo [                        Written By: Eric Walters                        ]
echo [------------------------------------------------------------------------]
echo.

rem Change directory into the folder where the cmd file is located
cd %~dp0

rem Check first that we have admin rights before continuing
call:check_Permissions

rem Check to see if Crestron SIMPL+ Compiler is even installed
call:check_Installation

rem Create the compile batch file
call:DropCompileCmd

rem Import the registry file that adds the new instances to the context menu
call:DropRegFile
reg import Add_to_context.reg
del Add_to_context.reg

rem Jump to end
goto:end_script

rem [------------------------------------------------------------------------]
rem [                          Utility Subroutines                           ]
rem [------------------------------------------------------------------------]

rem This checks to make sure we have admin rights, otherwise none of this will work.
:check_Permissions
echo Administrative permissions required. Detecting permissions...

net session >nul 2>&1
if %errorLevel% == 0 (
	echo Passed.
	echo.
	exit /b
) else (
	echo Failed. This file MUST be run as an administrator. Please use the Run As Administrator option after right clicking on this file.
	echo.
	goto:end_script
)

rem Check for XPanel folder:check_Installation
:check_Installation
if not exist "C:\Program Files (x86)\Crestron\SIMPL\SplusCC.exe" (
    echo Can't find Crestron SIMPL+ compiler. Are you sure it's installed?
    echo.
    goto:end_script
)
exit /b

rem This creates the batch file that compiles then pauses to see the output
:DropCompileCmd
if not exist "C:\CompileSplus" (
    echo Creating C:\CompileSplus folder
    mkdir C:\CompileSplus
)

if exist "C:\CompileSplus\CompileSplus.cmd" (
    del "C:\CompileSplus\CompileSplus.cmd"
)

(
    echo "C:\Program Files (x86)\Crestron\Simpl\SplusCC.exe" \rebuild %%1 \target %%2 %%3 %%4
    echo pause
)>"C:\CompileSplus\CompileSplus.cmd"
exit /b

rem This creates the registry file that gets imported
:DropRegFile
if exist Add_to_context.reg ( del Add_to_context.reg )

(
echo Windows Registry Editor Version 5.00
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\DefaultIcon]
echo @="C:\\Program Files (x86)\\Crestron\\Simpl\\S3_SPls.exe ,0"
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 2 + 3 Series]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 2 + 3 Series\command]
echo @="C:\\CompileSplus\\CompileSplus.cmd \"%%1\" series2 series3"
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 2 Series]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 2 Series\command]
echo @="C:\\CompileSplus\\CompileSplus.cmd \"%%1\" series2"
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 3 + 4 Series]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 3 + 4 Series\command]
echo @="C:\\CompileSplus\\CompileSplus.cmd \"%%1\" series3 series4"
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 3 Series]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 3 Series\command]
echo @="C:\\CompileSplus\\CompileSplus.cmd \"%%1\" series3"
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 4 Series]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Compile 4 Series\command]
echo @="C:\\CompileSplus\\CompileSplus.cmd \"%%1\" series4"
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Open]
echo.
echo [HKEY_CLASSES_ROOT\CrestronSplus\shell\Open\command]
echo @="C:\\Program Files (x86)\\Crestron\\Simpl\\S3_SPls.exe  \"%%1\""
)>"Add_to_context.reg"
exit /b

rem [------------------------------------------------------------------------]
rem [                       End of Script: Done Here                         ]
rem [------------------------------------------------------------------------]
:end_script
rem Done here.
echo.
echo Press any key.
pause > nul
exit
