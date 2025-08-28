#[derive(Debug)]
pub struct Item {
    pub weight: u32,
    pub value: u32,
}

pub fn maximum_value(max_weight: u32, items: &[Item]) -> u32 {
    let mut values = vec![vec![0; items.len() + 1]; max_weight as usize + 1];
    for i in 1..=items.len() {
        for w in 1..=max_weight as usize {
            values[w][i] = values[w][i - 1];
            if items[i - 1].weight as usize <= w {
                values[w][i] = values[w][i]
                    .max(values[w - items[i - 1].weight as usize][i - 1] + items[i - 1].value);
            }
        }
    }
    values[max_weight as usize][items.len()]
}
