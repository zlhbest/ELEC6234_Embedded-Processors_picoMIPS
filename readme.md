利用SystemVerilog语言编写FPGA 实现picoMIPS并且能够进行仿射变换的计算
* 使用的软件及版本
  * quartus II 13.1
  * modelsim SE 10.4
  * vscode

* 使用的语言
  * systemVerilog

### picoMIPS架构

<img src="./img/picoMIPS_version_1.png" >

#### 组件
* PC(Program Counter) : 程序计数器
  * PC的主要功能是取memory中的数据。 
  * 输入: 时钟, 复位, 是否跳转的标志位(因为在程序中不只有+1的顺序执行还有需要jump)
  * 输出: 程序地址
  * 实现文件: pc.sv
* Decoder: 解码器 :
  * 用于解析memory中的指令应该去往什么位置
* Regs: 寄存器 :
  * 主要功能是存储中间设备
* ALU: 逻辑计算单元
