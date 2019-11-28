# cache 实验所需的文件，包括CPU代码、Cache代码、benchmark生成器

* CacheSrcCode 中包含 Cache 的实现代码，以及对 Cache 进行独立的、脱离 CPU 测试的testbench生成器
* CPUSrcCode 中包含 CPU 代码，它调用 Cache，并在流水线中对cache miss 的情况进行 流水线Stall处理。同时进行hit和miss次数的统计（详见WBSegReg.v）
* ASM-Benchmark 中包含了快速排序和矩阵乘法这两种测试样例，并能使用python脚本生成不同规模的随机测试样例。

了解 Cache 实验的实验安排，请见 5_DetailDocuments 中的 Lab4-Cache实验-实验要求.docx

了解 Cache 实验第一阶段的指导，请见 王轩-cache编写指导.docx

了解 Cache 实验第二阶段的指导，请见 王轩-cache实验指导.docx
