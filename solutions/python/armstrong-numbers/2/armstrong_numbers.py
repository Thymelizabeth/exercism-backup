def is_armstrong_number(number):
    return sum(map((lambda x: int(x) ** len(str(number))), str(number))) == number