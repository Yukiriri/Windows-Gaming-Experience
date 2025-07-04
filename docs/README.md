# Windows-Gaming-Experience
一份对Windows游戏的CPU性能、丝滑度、跟手等因素的研究心得  
我从2021年就开始日积月累研究，浅到系统表层操作，深到上手游戏引擎开project，已经能总结一些明显成效  
我归纳的步骤已经提纯精华，省略了过多的收益不大的操作  
按下面的一整套流程走一遍就好，Intel和AMD通用，台式和笔记本也通用  
如果想贡献更丰富的调优，欢迎  

## 系统版本
尽可能上最新的`Win11 24H2`，并且至少`26100.3775`  
当然了，条件不允许就不强求了  

## 系统设置选项
|                 | 系统版本 | 建议 | 系统版本 | 建议       |
| :-------------- | :------- | :--- | :------- | :--------- |
| 硬件加速GPU计划 | <=23H2   | 不开 | >=24H2   | 不开白不开 |
| 窗口化游戏优化  | <=23H2   | 不开 | >=24H2   | 可以开     |

## 驱动
- `芯片组驱动`和`显卡驱动`需要定期更新  
- `网卡驱动`不要太老就好  

## 修复系统Tick
管理员运行以下几行cmd命令
```
bcdedit /deletevalue useplatformclock >nul
```
```
bcdedit /set useplatformtick no
```
```
bcdedit /set disabledynamictick yes
```
上面的效果是恢复默认TSC，阻止使用RTC  
虽然使用RTC可以提高一些帧数上限，但是会大幅增加CPU占用，还会严重破坏所有游戏的骨骼动画的连贯度  
有人说AMD骨骼动画卡顿是因为`Clock Stretching`的原因，但我的实验证明，罪魁祸首单纯是RTC  
如果你要用8000HZ的鼠标，强烈建议阻止RTC  

> [!IMPORTANT]
> 需要重启生效  

> [!NOTE]
> 运行一次即整个系统永久保持，不需要加入开机自启  
> 除非撤销了这些BCD选项，或者使用了新系统  

## 电源计划
老生常谈的Windows大小核调度  
  
关于这个，无论在23H2以前还是24H2以后，不同型号的全大核以及单CCD的CPU仍然可能会出现完全不同的线程调度，好怪哦  
如果仍然有全大核调度问题需要解决，可以管理员运行下面的cmd命令  
- 生效的异类策略
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\7f2f5cfa-f10c-4823-b5e1-e93ae85f46b5" /v "Attributes" /t REG_DWORD /d 2 /f
    ```
    ```
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "7f2f5cfa-f10c-4823-b5e1-e93ae85f46b5" 4
    ```
- 异类线程调度策略
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\93b8b6dc-0698-4d1c-9ee4-0644e900c85d" /v "Attributes" /t REG_DWORD /d 2 /f
    ```
    ```
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "93b8b6dc-0698-4d1c-9ee4-0644e900c85d" 0
    ```
- 异类短运行线程调度策略
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\bae08b81-2d5e-4688-ad6a-13243356654b" /v "Attributes" /t REG_DWORD /d 2 /f
    ```
    ```
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "bae08b81-2d5e-4688-ad6a-13243356654b" 0
    ```
- （可选）处理器闲置时间检查
    ```
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\c4581c31-89ab-4597-8e2b-9c9cab440e6b" /v "Attributes" /t REG_DWORD /d 2 /f
    ```
    ```
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR "c4581c31-89ab-4597-8e2b-9c9cab440e6b" 30
    ```
- 让修改生效
    ```
    powercfg -setactive SCHEME_CURRENT
    ```

> [!NOTE]
> 运行一次即整个电源计划生效，不需要加入开机自启  
> 除非切换电源计划，才需要给新电源计划重新运行一次  

> [!TIP]
> 顺便提一下我的调度修改程序：[`ReimagedScheduling`](https://github.com/Yukiriri/ReimaginedScheduling)

## 关闭鼠标增强指针精度
这是一项大幅影响鼠标手感的参数，推荐FPS选手  
cmd命令：
- 关闭增强指针精度
    ```
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
    ```
    ```
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
    ```
    ```
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
    ```
- 恢复系统默认
    ```
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "1" /f
    ```
    ```
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "6" /f
    ```
    ```
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "10" /f
    ```

> [!NOTE]
> 运行一次即整个系统永久保持，不需要加入开机自启  
> 除非恢复默认，或者使用了新系统  

## 修改前后台调度运作
这是一项细微影响鼠标手感的参数，推荐FPS选手  
  
`Win32PrioritySeparation`二进制位解释
|          | 5~6位     | 3~4位      | 1~2位          |
| :------- | :-------- | :--------- | :------------- |
| 解释     | 时间长短  | 长短可变性 | 前后台时间比例 |
| 数值作用 | 00 = 默认 | 00 = 默认  | 00 = 1:1       |
| 数值作用 | 01 = 长   | 01 = 可变  | 01 = 2:1       |
| 数值作用 | 10 = 短   | 10 = 固定  | 10 = 3:1       |

举例：
- 二进制 101010 表示固定短3:1调度 对应十进制42 十六进制2a
- 二进制 010110 表示可变长3:1调度 对应十进制22 十六进制16

建议：
- 高灵敏度玩家使用42
- 低灵敏度玩家使用22

cmd命令：
- 42
    ```
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2a /f
    ```
- 22
    ```
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 16 /f
    ```
- 恢复系统默认
    ```
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f
    ```

> [!NOTE]
> 运行一次即整个系统永久保持，不需要加入开机自启  
> 除非恢复默认，或者使用了新系统  

## 缓解系统动画掉帧
NVIDIA RTX30+开始，存在低负载时系统动画掉帧  
以下cmd命令可以大幅缓解掉帧  
```
nvidia-smi -lmc 800,-1
```
其中，`800`表示最低显存频率不会低于`800MHZ`，因为掉帧的原因就是显存休眠过头，而唤醒显存又过慢  

> [!NOTE]
> 越高就越不会掉帧  
> 但要注意，最低频率给太高会明显增加显卡空转功耗，这里给的`800`只增加了几W功耗  
> 如果要更高，请自己确认显卡功耗能不能接受  

> [!NOTE]
> 这个修改仅够维持本次开机，如果要永久生效，需要加入开机自启  
> 严格来说只维持本次驱动会话，驱动状态更改后就被重置  

## 关于AMD BIOS老生常谈的选项
`PSS Support`、`CPPC PC`、`Global C State`现在已经没必要动了，全Auto也没问题的！！

## 以上操作懒人化
想要全自动操作上面的步骤吧，我知道，但先咕一会儿

# 游戏本温度压制方案
[gaming-laptop-temperature.md](./gaming-laptop-temperature.md)

# Credits
- https://sites.google.com/view/melodystweaks/misconceptions-about-timers-hpet-tsc-pmt
