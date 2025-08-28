def is_armstrong_number(number):
    return sum(map((lambda x: x ** len(str(number))), map((lambda x: int(x)), str(number)))) == number