import fire
import redis
import os


def ls():
    return os.listdir()


def get(key):
    r = redis.Redis()
    return r.get(key).decode('utf-8')


def set(key, value):
    r = redis.Redis()
    return r.set(key, value.encode('utf-8'))


def ernn():
    from utils.ernn import ernn_result
    root = get('ernnRoot')
    return ernn_result(root)

fire.Fire()
