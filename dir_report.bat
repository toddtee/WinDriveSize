@ECHO OFF
SET ScriptDirectory=%~dp0
SET pshellScript=%ScriptDirectory%dir_info.ps1
SET /p drive=Enter drive you would like to analyse...  
@echo Analysing Files...
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File %pshellScript% %drive%
@echo Finished. Please find your .csv file.
PAUSE

