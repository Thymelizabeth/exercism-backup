use std::collections::HashSet;
use std::collections::HashMap;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut result = HashSet::new();
    for possible_anagram in possible_anagrams {
        if is_anagram(word, possible_anagram) {
            result.insert(*possible_anagram);
        }
    }
    result
}

fn is_anagram(word: &str, possible_anagram: &str) -> bool {
    let word = word.to_lowercase();
    let possible_anagram = possible_anagram.to_lowercase();
    if word == possible_anagram {
        return false;
    }
    let word = word.chars().fold(HashMap::new(), |mut acc, c| { *acc.entry(c).or_insert(0) += 1; acc });
    let possible_anagram = possible_anagram.chars().fold(HashMap::new(), |mut acc, c| { *acc.entry(c).or_insert(0) += 1; acc });
    word == possible_anagram
}