'''
Date: 2021-03-24 15:43:41
Author: Mengsen Wang
LastEditors: Mengsen Wang
LastEditTime: 2021-03-24 17:28:54
'''

import os
import numpy as np
import matplotlib.pyplot as plt
from concurrent.futures import ThreadPoolExecutor
import opensees.openseespy as ops


def run(arg_1, arg_2, arg_3, arg_4):

    model = ops.Model(ndm=3, ndf=6)

    model.node(1, 0.0, 0.0, 0.0)
    model.node(2, 0.0, 3.2, 0.0)
    model.fix(1, 1, 1, 1, 1, 1, 1)

    model.uniaxialMaterial('Concrete01', 1, -80.0e6, -0.002, 0.0, -0.005)

    model.section('Fiber', 1, '-GJ', 1)
    model.patch('rect', 1, 10, 10, -0.8, -0.1, 0.8, 0.1)

    model.geomTransf('Linear', 1, 0, 0, 1)
    model.beamIntegration('Legendre', 1, 1, 10)
    model.element('dispBeamColumn', 1, 1, 2, 1, 1)

    model.timeSeries('Linear', 1)
    model.pattern('Plain', 1, 1)
    model.load(2, 0, -24586.24, 0, 0, 0, 0)

    model.constraints('Plain')
    model.numberer('RCM')
    model.system('UmfPack')
    model.test('NormDispIncr', 1.0e-6, 2000)
    model.algorithm('Newton')
    model.integrator('LoadControl', 0.01)
    model.analysis('Static')
    model.analyze(100)

    model.wipeAnalysis()
    model.loadConst('-time', 0.0)

    model.recorder('Node', '-file', 'disp.out', ' -time',
                 '-node',  2, '-dof', 1, 'disp')
    model.recorder('Node', '-file', 'react.out', '-time ',
                 '-node', 2, '-dof', 1, 'reaction')

    model.timeSeries('Linear', 2)
    model.pattern('Plain', 2, 2)
    model.load(2, 11500, 0, 0, 0, 0, 0)
    model.constraints('Plain')
    model.numberer('RCM')
    model.system('UmfPack')
    model.test('NormDispIncr', 1.0, 2000)
    model.algorithm('Newton')
    model.integrator('LoadControl',  0.01)
    model.analysis('Static')
    # model.analyze(100)

    step = 100
    data = np.zeros((step, 2))
    for i in range(step):
        model.analyze(1)
        data[i, 0] = model.nodeDisp(2, 1)
        data[i, 1] = model.getLoadFactor(2) * 11500
    return data
    # plt.plot(data[:, 0], data[:, 1])
    # plt.xlabel('Horizontal Displacement')
    # plt.ylabel('Horizontal Load')
    # plt.show()
