import numpy as np
from functools import wraps


class Counted:
    def __init__(self, fn):
        self.cnt = 0
        self.fn = fn

    @property
    def count(self):
        return self.cnt

    def reset(self):
        self.cnt = 0

    def __call__(self, *args, **kwargs):
        res = self.fn(*args, **kwargs)
        self.cnt += 1
        return res

def counted(fn):
    return wraps(fn)(Counted(fn))



def is_pow2(n):
    return (n & (n-1) == 0) and n != 0

@counted
def acha_slow(M, x, a=0, b=0, n=None):
    if n is None:
        n = len(M)
        assert is_pow2(n) and len(M[0]) == n

    if n == 1:
        if M[a, b] == x:
            return a, b
        else:
            return None

    for i in range(0, n, n//2):
        for j in range(0, n, n//2):

            res = acha_slow(M, x, a+i, b+j, n//2)
            if res is not None:
                return res


@counted
def acha(M, x, a=0, b=0, n=None):
    if n is None:
        n = len(M)
        assert is_pow2(n) and len(M[0]) == n
    if n == 1:
        if M[a, b] == x:
            return a, b
        else:
            return None

    mid = a+n//2-1, b+n//2-1
    if x == M[mid]:
        return mid
    elif x < M[mid]:
        res = acha(M, x, a, b, n//2)
    else:
        res = acha(M, x, a+n//2, b+n//2, n//2)

    if res is not None:
        return res
    res = acha(M, x, a, b+n//2, n//2)
    if res is not None:
        return res
    return acha(M, x, a+n//2, b, n//2)



mat = np.loadtxt('ex1.txt')

def checa(x, show=True):
    pos = acha_slow(mat, x)
    if pos is None:
        ok = x not in mat
    else:
        ok = mat[pos] == x

    pos = acha(mat, x)
    if pos is None:
        res = x not in mat
    else:
        res = mat[pos] == x

    if show:
        print(f'{x=}', f'{pos=}', f'{ok=}', f'{res=}')

    return ok and res
