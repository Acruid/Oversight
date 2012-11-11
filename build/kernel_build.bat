@ECHO OFF
cd %~dp0

SETLOCAL
SET BUILDNAME=kernel
SET OBJLIST=

IF NOT EXIST ..\bin MKDIR ..\bin
DEL /Q ..\bin\*.*
IF NOT EXIST ..\bin\%BUILDNAME% MKDIR ..\bin\%BUILDNAME%
DEL /Q ..\bin\%BUILDNAME%\*.*
CD ..\src\%BUILDNAME%

SETLOCAL DisableDelayedExpansion
SET "r=%__CD__%"
FOR /R . %%F IN (*.dasm) DO (
  SET "p=%%F"
  SETLOCAL EnableDelayedExpansion
  ECHO(---- dtasm !p:%r%=!
  SET OBJLIST=!OBJLIST! %%~nF.dobj16 
  dtasm -s ..\..\bin\%BUILDNAME%\%%~nF.dsym16 -o ..\..\bin\%BUILDNAME%\%%~nF.dobj16 !p:%r%=!
)

cd %~dp0\..\bin\%BUILDNAME%
ECHO ---- dtld
dtld -l kernel --jumplist ..\%BUILDNAME%.djmp16 -s ..\%BUILDNAME%.dsym16 -o ..\%BUILDNAME%.dkrn16 %OBJLIST%