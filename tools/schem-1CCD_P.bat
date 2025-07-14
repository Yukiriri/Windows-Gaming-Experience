reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\7f2f5cfa-f10c-4823-b5e1-e93ae85f46b5" /v "Attributes" /t REG_DWORD /d 2 /f
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "7f2f5cfa-f10c-4823-b5e1-e93ae85f46b5" 4

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\93b8b6dc-0698-4d1c-9ee4-0644e900c85d" /v "Attributes" /t REG_DWORD /d 2 /f
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "93b8b6dc-0698-4d1c-9ee4-0644e900c85d" 0

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\bae08b81-2d5e-4688-ad6a-13243356654b" /v "Attributes" /t REG_DWORD /d 2 /f
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "bae08b81-2d5e-4688-ad6a-13243356654b" 0

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\c4581c31-89ab-4597-8e2b-9c9cab440e6b" /v "Attributes" /t REG_DWORD /d 2 /f
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "c4581c31-89ab-4597-8e2b-9c9cab440e6b" 30

powercfg -setactive SCHEME_CURRENT
