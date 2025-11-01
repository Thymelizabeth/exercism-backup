pub fn recite(start_bottles: u32, take_down: u32) -> String {
    const numbers: [&str; 11] = ["No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
    let mut result = String::new();
    for num_bottles in (((start_bottles-take_down + 1) as usize)..=(start_bottles as usize)).rev() {
        if num_bottles as u32 != start_bottles - take_down {
            result += "\n\n";
        }
        let bottle = if num_bottles == 1 {
            "bottle"
        } else {
            "bottles"
        };
        result += format!("{} green {} hanging on the wall,\n{} green {} hanging on the wall,\nAnd if one green bottle should accidentally fall,\nThere'll be {} green {} hanging on the wall.", numbers[num_bottles], bottle, numbers[num_bottles], bottle, numbers[num_bottles - 1].to_lowercase(), if num_bottles - 1 == 1 { "bottle" } else { "bottles" }).as_str();
    }
    result
}
