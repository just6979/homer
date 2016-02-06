reg add "HKCR\*\OpenWithList\Notepad2.exe" /f
reg add "HKCR\Applications\Notepad2.exe" /v "AppUserModelID" /t REG_SZ /d "Notepad2" /f
reg add "HKCR\Applications\Notepad2.exe\shell\open\command" /ve /t REG_SZ /d "\"%~dp0Notepad2.exe\" %%1" /f
