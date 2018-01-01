#!/usr/bin/python3

import os
import multiprocessing


def getResult(path):
    d = path[0]
    sub = path[1]
    i = path[2]
    with open(os.path.join(d, sub, i, 'cell.lua')) as fd:
        performance = fd.readline().split()[1].strip()
        try:
            performance = float(performance)
            if performance < 0:
                return
            return ((int(i), performance))
        except:
            pass


def ernn_result(d):

    result = []

    dirs = [(d, 'live', i) for i in os.listdir(os.path.join(d, 'live'))] + \
        [(d, 'dead', i) for i in os.listdir(os.path.join(d, 'dead'))]

    pool = multiprocessing.Pool(16)
    result = [i for i in pool.imap_unordered(getResult, dirs) if i]
    pool.close()
    pool.join()
    result = sorted(result, key=lambda x: x[0])
    # print(max([i[1] for i in result]))
    return sorted(result, key=lambda x: x[1])[-1]
