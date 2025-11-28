use std::collections::HashSet;
pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    factors
    .iter()
    .map(|factor|
         (1..)
         .map_while(|x|
                    (factor.checked_mul(x)? < limit && (*factor != 0 || x == 1))
                    .then(|| factor * x))
         .collect::<HashSet<_>>())
    .fold(HashSet::new(), |acc, x| x.union(&acc).copied().collect())
    .into_iter()
    .sum()
}
