from functools import reduce

def score(word):
    points = dict(zip(map(chr, range(ord("a"), ord("z") + 1)), [1,3,3,2,1,4,2,4,1,8,5,1,3,1,1,3,10,1,1,1,1,4,4,8,4,10]))
    return reduce(lambda acc, x: acc + points[x.lower()], word, 0)
