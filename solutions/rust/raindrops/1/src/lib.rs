use std::collections::BTreeMap;

pub fn raindrops(n: u32) -> String {
    let sound_map: BTreeMap<u32, &str> = BTreeMap::from([(3, "Pling"), (5, "Plang"), (7, "Plong")]);
    let result = sound_map.iter().fold(
        "".to_string(),
        |acc, (&k, &v)| if n % k == 0 { acc + v } else { acc },
    );
    if result.is_empty() {
        n.to_string()
    } else {
        result
    }
}
