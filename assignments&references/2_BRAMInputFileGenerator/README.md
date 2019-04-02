2_BRAMInputFileGenerator
=====================
####此文件夹用于存放文件处理MakeFile脚本，Makefile具体用法参加Makefile文件注释。  
* Utils文件夹内预置了编译好的riscv-tools，Makefile需要调用到，Ubuntu-64bit机器应该都可以运行
* ExampleCode/ASMCode中包含了一些简单的汇编测试文件，文档尚无
* ExampleCode/RISCVTest_rv32ui中包含了已经经过cpp程序预处理过的汇编文件，预处理前的汇编代码放在SourceCode文件夹中（你应该用不到）
* ExampleCode/RISCVTest_rv32ui中代码修改自https://github.com/riscv/riscv-tests ，总共包含800+项riscv CPU功能测试，作为最终的验收标准

####你只需要将需要处理的.S文件放置到Makefile相同路径下，执行make既可以获得你需要的.inst和.data文件，用于初始化CPU的blcok memory

