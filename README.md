# 对 OpenSees 使用记录

## [简单的算例设计方法](https://github.com/Mengsen-W/OpenSeesFiles/tree/master/Example-test "Example test")

1. 默认的质量实际上不是进行重力分析，而是进行动力分析所有，重力分析要以加载力的方式进行。

2. 可以先进行重力作用分析，后进行 pushover 分析，此时一些分析指令如果不在需要更改，就不需要重新写出来。

3. 若一次分析后不需要场面的持序作用，即使用 wipeAnalysis 命令。

## [二维弹性柱的静、动力分析](https://github.com/Mengsen-W/OpenSeesFiles/tree/master/ElasticColumn "Elastic Column")

1. 增加迭代步数减小步长会提高精确度，但可能会导致不收敛，误差约在 5% 左右

2. 在位移控制的时候，加载模式中给出的加载力其实是一种比例关系，随后的输出文件的第一列不是时间，而是力的系数。也就是说此系数乘加载力为实际的力大小。

3. 地震波文件没办法取得，生成的地震反应可能也是错的。

## [三维剪力墙的滞回曲线分析](https://github.com/Mengsen-W/OpenSeesFiles/tree/master/ShearWall "Shear Wall")

1. 对于剪力墙，壳单元更能充分反应其剪压复合的特点。

2. 剪力墙的壳单元能少建大约 1/3 的单元数量，有效提高了分析的效率

3. 梁类型的单元需要转换坐标系

4. OpenSees 不需要特殊指出约束，因为他们依靠节点传递应力应变

## [三维剪力墙 timeSeries 方法](https://github.com/Mengsen-W/OpenSeesFiles/tree/master/TimeSeriesShearWall "Time Series Shear Wall")

1. 对于箍筋层，小范围变化影响不大

2. 关键在于混凝土的厚度和一些端部钢筋

## FRP剪力墙

1. 对 于FRP/SFCB 剪力墙可能要加大剪力墙剪切系数

2. 调整 SFCB 的初始模量影响不大

### **(测试中... )**

## 命令说明

1. constrains 命令是用于确定施加边界条件的方法
    1. Plain 方法用于构造简单的约束，是以约束矩阵的形式施加，容易导致不收敛

    2. Lagrange 是使用拉格朗日乘子发得到一个势最低的点用来施加约束，有可能无法找到最小值导致约束失败，受积分点不同影响很大

    3. Penalty 罚函数法，依赖于罚函数的选取，对于一些复杂得多的问题，罚函数往往能在速度与精确性之间的到满足。而对于一般问题，罚函数显得速度有些慢。

    4. Transformation 变换约束，利用一个试探性的位移对于约束的单点；对于单点多约束问题可能无法满足，因为变换约束只能满足一个约束，甚至一个都不满足。

2. uniaxialMaterial Hysteretic 用来模拟复合筋的情况
    1. 如果第三个点比第二个点大，那么之后的斜率会按前两个点的斜率上升

    2. 如果第三个点比第二个点小，那么之后会以第三个点后的应力是一条恒定的直线

    3. pinchx, pinchy, damage1, damage2 beta 如何计算目前仍不明确；但是可以在[这](https://opensees.berkeley.edu/OpenSees/manuals/usermanual/4052.htm)看到更改的会产什么样的变换。
        1. pinchx pinchy 的减小会使图像项远点捏缩
        2. pinchx减小会使图像平行于y轴
        3. damage1 上升会使图像在大应力下分别捏缩到x y 轴
        4. damage2和beta的改变没有看到明显的影响

3. 迭代计算方法
    1. 牛顿法无疑迭代次数最少，但每次迭代都需重构刚度矩阵

    2. 修正牛顿法为常刚度迭代，无需重构刚度矩阵但增加了迭代次数

    3. 拟牛顿法（如割线法、BFGS等）简化了形成刚度矩阵的方法，性能介于牛顿法与拟牛顿法之间

    4. 带线搜索的牛顿迭代法则是求解f(x)的极小值min(f(x))。线搜索迭代式中，λ为搜索步长系数，pk为搜索方向

    5. Krylov，通过牺牲精度来换取求解速度。当求解线性方程组KU=F（K为刚度矩阵，U为未知的位移向量，F为不平衡力向量）时，其简化了稀疏矩阵的求拟过程

    6. 在实际的计算中发现从迭代耗时的角度，降低迭代次数与减少刚度矩阵组装工作量相比，降低迭代次数更有意义

    7. 推荐求解器的顺序为：小容差带线搜索的牛顿迭代法效果大于Krylov算法，Krylov算法的性能略优于牛顿法，之后是线性牛顿法，最后是修正牛顿法。因修正牛顿法过早的退出了工作，导致其迭代性能不优秀.

4. 不要用有明显弯折点的材料处理，会导致滞回曲线部连续，出现空洞。

5. Steel02 第一个参数取值范围是10-20，但是取15大概率导致不收敛，调整纵筋对模型影响不大

### 模型说明

1. SFI-MVLEM单元采用修正固定支撑角模型（FSAM），该模型可考虑骨料的剪切互锁效应和纵筋的销栓作用，从而保证该单元能够更准确的模拟剪力墙复杂的非线性行为

    1. SFI-MVLEM既可准确模拟大剪跨比（弯控）剪力墙构件的力学性能，又能较好模拟小剪跨比剪力墙的承载力及耗能能力

        1. SFI-MVELM中的骨料剪切互锁系数μ取值范围为0~1.5，Orakcal根据模拟结果认为μ取值为0.2时可保证较好的模拟效果，构件承载力随着骨料剪切互锁系数μ的增大而增大

        2. 对于构件力位移曲线：由于骨料剪切互锁系数μ控制着混凝土的抗剪能力，其抗剪能力随着系数μ的增大而增大，因此构件承载力随着骨料剪切互锁系数μ的增大而增大。

        3. 对于单元剪切力学性能：单元的剪切变形量随着骨料剪切互锁系数μ的增大而减小。由于混凝土骨料剪切互锁模型的影响，单元的捏缩效应随着骨料剪切互锁系数μ的增大而减弱。

    2. SFI-MVELM中的销栓作用系数α 取值范围为0~0.05，

        1. 对于构件力位移曲线：由于销栓作用系数α控制着纵筋的抗剪刚度，其抗剪刚度随着系数的增大而增大，因此在相同的水平位移下，构件承载力随着销栓作用系数的增大而增大。

        2. 对于单元剪切力学性能：单元的剪切变形量随着销栓作用系数的增大而减小。由于纵筋销栓作用模型的影响，单元的捏缩效应随着销栓作用系数的增大而减弱

2. MVLEM单元由多个竖向纤维弹簧和一个水平剪切弹簧组成
    1. MVLEM 准确模拟大剪跨比（弯控）剪力墙构件的力学性能，但高估了小剪跨比剪力墙的承载力及耗能能力

    2. 转心处的曲率决定单元的相对转动值，而转心的位置则由参数c = 0.4 所决定

    3. OpenSees中的MVLEM为二维单元，因此在使用中具有一定的局限性。而位移元纤维单（DispBeamColumn）则可为三维单元，且其与MVLEM单元均是基于刚度法的纤维单元，两者单元原理相近。

        1. 对于弯控为主的剪力墙构件和剪力墙结构，位移元纤维单元的模拟效果与MVLEM单元基本相同，因此可利用位移元纤维单元来模拟弯控为主的剪力墙单元。

        2. 由于MVLEM单元具有剪切弹簧，而常规的位移元纤维单元不具备截面剪切刚度，因此对于剪控为主的剪力墙构件，MVLEM单元的耗能性能低于位移元纤维单元。

3. 分层壳单元考虑了面内弯曲、面内剪切、面外弯曲之间的耦合作用，能较全面的反映壳体结构的空间力学性能。
    1. 对于壳单元剪力墙调整剪切系数能得到滞回曲线产生可观测的变化，但是调高剪切系数后可能导致模型的收敛性变差。

    2. OpenSees分层壳包含剪力传递系数β，用于考虑混凝土开裂对其剪切模量的折减作用，取值范围在0~1之前。0表示不传递剪力，即混凝土间的咬合作用完全丧失；1表示剪力传递未损失，即开裂后混凝土剪切模量不发生改变。

        1. 超过1后影响不大，钢筋层会导致应力过小
