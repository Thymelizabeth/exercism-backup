#[derive(Debug)]
pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

type Dice = [u8; 5];

pub fn score(dice: Dice, category: Category) -> u8 {
    match category {
	Category::Ones => number_of(1, dice),
	Category::Twos => number_of(2, dice),
	Category::Threes => number_of(3, dice),
	Category::Fours => number_of(4, dice),
	Category::Fives => number_of(5, dice),
	Category::Sixes => number_of(6, dice),
	Category::FullHouse => full_house(dice),
	Category::FourOfAKind => four_of_a_kind(dice),
	Category::LittleStraight => straight([1,2,3,4,5], dice),
	Category::BigStraight => straight([2,3,4,5,6], dice),
	Category::Choice => dice.iter().sum(),
	Category::Yacht => yacht(dice),
    }
}

fn number_of(n: u8, dice: Dice) -> u8 {
    dice.iter().map(|&d| if d == n { 1 } else { 0 }).sum::<u8>() * n
}

fn full_house(dice: Dice) -> u8 {
    let dice_count = dice.into_iter().map(|d| dice.into_iter().filter(|&v| v == d).count()).collect::<Vec<_>>();
    if dice_count.contains(&2) && dice_count.contains(&3) {
	dice.iter().sum()
    }
    else {
	0
    }
}

fn straight(combo: Dice, dice: Dice) -> u8 {
    let mut dice = dice;
    dice.sort();
    if dice == combo {
	30
    } else {
	0
    }
}

fn four_of_a_kind(dice: Dice) -> u8 {
    dice.into_iter()
	.find(|d| dice.into_iter()
		.filter(|v| v == d).
		count() >= 4)
	.unwrap_or(0) * 4
}

fn yacht(dice: Dice) -> u8 {
    if dice.into_iter().all(|d| dice[0] == d) {
	50
    } else {
	0
    }
}
