pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let row_len = diagram.lines().next().unwrap().chars().count();
    let input = diagram
        .lines()
        .flat_map(|row| row.chars())
        .collect::<Vec<char>>();
    let col_len = input.len() / row_len;
    let mut t_input = Vec::with_capacity(input.len());
    for i in 0..row_len {
        for j in 0..col_len {
            let c = input[j * row_len + i];
            t_input.push(match c {
                'C' => "clover",
                'G' => "grass",
                'R' => "radishes",
                'V' => "violets",
                _ => unimplemented!(),
            });
        }
    }
    println!("{:?}", input);
    println!("{:?}", t_input);
    let i = student.as_bytes()[0] as usize - 65;
    vec![
        t_input[i * 4],
        t_input[i * 4 + 2],
        t_input[i * 4 + 1],
        t_input[i * 4 + 3],
    ]
}
