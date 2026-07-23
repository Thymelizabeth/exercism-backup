pub fn encode(key: &str, s: &str) -> Option<String> {
    if key.is_empty() {
	return None;
    }
    let mut output = String::new();
    for (k, c) in key.bytes().cycle().zip(s.bytes()) {
        match k {
            b'a'..=b'z' => output.push(((c - b'a' + k - b'a') % 26 + b'a') as char),
            _ => return None,
        }
    }
    Some(output)
}

pub fn decode(key: &str, s: &str) -> Option<String> {
    if key.is_empty() {
	return None;
    }
    let mut output = String::new();
    for (k, c) in key.bytes().cycle().zip(s.bytes()) {
	match k {
	    b'a'..=b'z' => output.push(((c - b'a' + 26 - (k - b'a')) % 26 + b'a') as char),
	    _ => return None,
	}
    }
    Some(output)
}

pub fn encode_random(s: &str) -> (String, String) {
    use rand::distr::SampleString;
    let key = rand::distr::Alphabetic
        .sample_string(&mut rand::rng(), 100)
        .to_ascii_lowercase();
    let cyphertext = encode(&key, s).unwrap_or(String::from(""));
    (key, cyphertext)
}
