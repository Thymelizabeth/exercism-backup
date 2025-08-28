pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = Vec::new();
    string.chars().fold(true, |acc, c| match c {
        '(' | '{' | '[' => {
            stack.push(c);
            acc
        }
        ')' | '}' | ']' => match (stack.pop(), c) {
            (Some('('), ')') | (Some('{'), '}') | (Some('['), ']') => acc,
            _ => false,
        },
        _ => acc,
    }) && stack.is_empty()
}
