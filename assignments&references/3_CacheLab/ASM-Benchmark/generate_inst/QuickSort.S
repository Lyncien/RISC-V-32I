# 概述：对数组进行原地快速排序
# Author: WangXuan

.org 0x0
    .global _start
_start:

main:
    xor    a3, zero, 0x100     # 指定排序问题的规模。0x100则代表要给0x100=256个数字进行快速排序。
    
    lui    sp, 0x00001         # 设置栈顶指针 sp=0x1000 
    
    xor    a0, zero, zero      # 准备函数参数，a0=0, 说明要排序的数组的RAM起始地址为0
    xor    a1, zero, zero      # 准备函数参数，a1=0，说明从第0个字开始排序
    addi   a2, a3  , -1
    slli   a2, a2  , 2         # 准备函数参数，a2=数组最后一个元素的地址偏移。我们要排0x100=1024个数，最后一个数的地址为0x3fc
    
    jal    ra  , QuickSort     # 开始排序
infinity_loop:
    jal   zero, infinity_loop  # 排序结束，死循环

QuickSort:
    # 函数:QuickSort：以a0为基地址的原地升序快速排序，a1是start即开始下标，a2是end即结束下标
    # 例:  a0=0x00000100，a1=0, a2=31*4，则计算从0x00000100开始的32个字的快速排序
    # 注:  以有符号数为比较标准。例如0xffffffff应该排在0x00000001前面，因为0xffffffff代表-1，比1要小
    # 之所以使用低13位，因为13位二进制数取值范围位0~8191，不会超过4位十进制数
    # 改变数据RAM： 除了被排序的数组外，还使用了以sp寄存器为栈顶指针的栈。使用栈的大小根据排序长度而不同，调用前合理设置sp的值以防爆栈
    # 改变的寄存器： t0, t1, t2, t3, t4

        bge    a1, a2, QuickSortReturn                # if a1>=a2, end<=start, jump to return
        or     t1, a1, zero                           # t1=i=a1=start
        or     t2, a2, zero                           # t2=j=a2=end
        add    t0, a0, t1                             # 
        lw     t0, (t0)                               # t0=key=lst[start]

        PartationStart:          
            PartationFirstStart:                      # start of for loop
                bge    t1, t2, PartationEnd           # if i>=j, branch to next step
                add    t3, a0, t2                     # 
                lw     t3, (t3)                       # t3=lst[j]
                blt    t3, t0, PartationFirstEnd      # if lst[j]<key, branch to next step
                addi   t2, t2, -4                     # t2-=4  j--
                jal    zero, PartationFirstStart      # for loop
            PartationFirstEnd:                        # end of for loop
            add    t4  , a0, t1                       # t4=lst+i
            sw     t3  , (t4)                         # lst[i] = t3 = lst[j]
            
            PartationSecondStart:                     # start of for loop
                bge    t1, t2, PartationEnd           # if i>=j, branch to next step
                add    t3, a0, t1                     # 
                lw     t3, (t3)                       # t3=lst[i]
                blt    t0, t3, PartationSecondEnd     # if key<lst[i], branch to next step
                addi   t1, t1, 4                      # t1+=4  i++
                jal    zero, PartationSecondStart     # for loop
            PartationSecondEnd:                       # end of for loop 
            add    t4  , a0, t2                       # t4=lst+j
            sw     t3  , (t4)                         # lst[j] = t3 = lst[i]
            
            blt    t1, t2, PartationStart             # if t1<t2, branch to while start
        PartationEnd:

        add    t4  , a0, t1                           # t4=lst+i
        sw     t0  , (t4)                             # lst[i] = t0 = key
        
        addi   sp, sp, -4                              # sp-=4        
        sw     ra, (sp)                                # mem[sp] = ra # push ra to stack
        addi   sp, sp, -4                              # sp-=4
        sw     a1, (sp)                                # mem[sp] = a1 # push a1 to stack, save start
        addi   sp, sp, -4                              # sp-=4        
        sw     a2, (sp)                                # mem[sp] = a2 # push a2 to stack, save end
        addi   sp, sp, -4                              # sp-=4        
        sw     t1, (sp)                                # mem[sp] = t1 # push t1 to stack, save i
        addi   a2, t1, -4                              # a2 = i-4, a parameter for recursive call
        jal    ra  , QuickSort
        lw     t1, (sp)                                # pop i form stack 
        addi   sp, sp,  4                              # sp+=4
        lw     a2, (sp)                                # pop end form stack 
        addi   sp, sp,  4                              # sp+=4
        lw     a1, (sp)                                # pop start form stack 

        addi   sp, sp, -4                              # sp-=4        
        sw     a2, (sp)                                # mem[sp] = a2 # push a2 to stack, save end
        addi   sp, sp, -4                              # sp-=4        
        sw     t1, (sp)                                # mem[sp] = t1 # push t1 to stack, save i
        addi   a1, t1, 4                               # a1 = i+4, a parameter for recursive call
        jal    ra  , QuickSort
        lw     t1, (sp)                                # pop i form stack 
        addi   sp, sp,  4                              # sp+=4
        lw     a2, (sp)                                # pop end form stack 
        addi   sp, sp,  4                              # sp+=4
        lw     a1, (sp)                                # pop start form stack 
        addi   sp, sp,  4                              # sp+=4
        lw     ra, (sp)                                # pop ra form stack 
        addi   sp, sp,  4                              # sp+=4

    QuickSortReturn:                                   # 函数结尾
        jalr   zero, ra, 0                             # 返回

        


#
# QuickSort函数的等效C代码:
#   void QuickSort(int *lst, int start, int end){
#       if(end>start){
#           int i = start,j = end,key = lst[start];
#           while(i < j){
#               for (;i < j && key <= lst[j];j--);
#               lst[i] = lst[j];
#               for (;i < j && key >= lst[i];i++);
#               lst[j] = lst[i];
#           }
#           lst[i] = key;
#           QuickSort(lst, start, i - 1);
#           QuickSort(lst, i + 1, end);
#       }
#   }
#
#
        