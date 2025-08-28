from functools import reduce

def distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands must be of equal length.")
    return reduce(lambda acc, c: acc if c[0] == c[1] else acc + 1, zip(strand_a, strand_b), 0)