@echo off
cd %~dp0

dtasm -s ..\bin\kernel.dsym16 -o ..\bin\kernel.dobj16 ..\src\kernel\main.dasm
dtld -l kernel --jumplist ..\bin\kernel.djmp16 -o ..\bin\kernel.dkrn16 ..\bin\kernel.dobj16
copy /B /Y ..\bin\kernel.dkrn16 ..\bin\kernel.bin