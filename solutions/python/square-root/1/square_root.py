def square_root(number):
    for i in range(number//2 + 2):
        if i * i == number:
            return i
    return -1
