# CPU温度压制
- 让电源计划允许设置CPU最大频率
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Attributes" /t REG_DWORD /d 2 /f
    ```

> [!NOTE]
> 运行一次即可整个电源计划生效，不需要加入开机自启  

- 设置离电CPU频率上限
    ```
    powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e100" 3000
    ```
- 设置插电CPU频率上限
    ```
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "75b0ae3f-bce0-45a7-8c89-c9611c25e100" 3000
    ```

> [!NOTE]
> 运行一次即可整个电源计划生效，不需要加入开机自启  

> [!IMPORTANT]
> 其中，上面的`SCHEME_CURRENT`代表修改的是当前电源计划，`3000`代表的是频率上限，单位为`MHZ`  
> 如果要恢复为无上限，填0  

> [!NOTE]
> 3000只是个参考，每个人的机器的发热和散热能力都不同，按照你能接受的温度范围调整  
> 调大则增加性能上限，也增加发热和功耗，反之亦然  

# GPU温度压制

> [!NOTE]
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

> [!NOTE]
> 如果要永久生效，需要加入开机自启  

> [!IMPORTANT]
> 其中，`0`表示GPU最低可下降到的频率，`1500`则为最高上限，单位为`MHZ`  
> 还是老套路，按照能接受的温度范围调整  
