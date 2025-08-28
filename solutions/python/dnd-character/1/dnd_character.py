from math import floor
from random import randrange

class Character:
    def __init__(self):
        self.strength = self.ability()
        self.dexterity = self.ability()
        self.constitution = self.ability()
        self.intelligence = self.ability()
        self.wisdom = self.ability()
        self.charisma = self.ability()
        self.hitpoints = 10 + modifier(self.constitution)

    def ability(self):
        dice = [randrange(1, 7) for _ in range(4)]
        dice.sort()
        return sum(dice[1:])

def modifier(value):
    return floor((value - 10) / 2)
