use std::collections::BTreeMap;

pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h.into_iter().fold(BTreeMap::new(), |mut acc, (k, v)| {
        v.into_iter().for_each(|c| {
            acc.entry(c.to_ascii_lowercase()).or_insert(*k);
        });
        acc
    })
}
