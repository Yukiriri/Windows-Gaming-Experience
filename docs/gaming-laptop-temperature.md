# CPU温度压制
- 让电源计划允许设置CPU最大频率
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Attributes" /t REG_DWORD /d 2 /f
    ```
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e101" /v "Attributes" /t REG_DWORD /d 2 /f
    ```
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e102" /v "Attributes" /t REG_DWORD /d 2 /f
    ```

> [!NOTE]
> 运行一次即整个电源计划生效，不需要加入开机自启  
> 这个注册表特殊，切换了电源计划，也不需要重新运行  

- 设置离电CPU频率上限
    ```
    powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e100" 3000
    powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e101" 3000
    powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e102" 3000
    ```
- 设置插电CPU频率上限
    ```
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e100" 3000
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e101" 3000
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e102" 3000
    ```
其中，`3000`代表最高上限，单位为`MHZ`  
如果要恢复为无上限，改成`0`  

> [!NOTE]
> `3000`只是个参考，每个人的机器的发热和散热能力都不同，按照你能接受的温度范围调整  
> 调大则增加性能上限，也增加发热和功耗，反之亦然  

> [!NOTE]
> 运行一次即整个电源计划生效，不需要加入开机自启  
> 除非切换电源计划，才需要给新电源计划重新运行一次  

# GPU温度压制
> [!IMPORTANT]
> 仅限NVIDIA  
> 还没研究过A卡相关的工具套件  

- 设置GPU核心频率上限
    ```
    nvidia-smi -lgc 0,1500
    ```
- 恢复默认
    ```
    nvidia-smi -rgc
    ```
其中，`1500`代表最高上限，单位为`MHZ`  
还是老套路，按照能接受的温度范围调整  

> [!NOTE]
> 这个修改仅够维持本次开机，如果要永久生效，需要加入开机自启  
> 严格来说只维持本次驱动会话，驱动状态更改后就被重置  
