#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    match (first_list, second_list) {
        ([], []) => Comparison::Equal,
        ([], _) => Comparison::Sublist,
        (_, []) => Comparison::Superlist,
        _ => {
            if first_list
                .windows(second_list.len())
                .any(|sublist| sublist == second_list)
            {
                if first_list.len() == second_list.len() {
                    Comparison::Equal
                } else {
                    Comparison::Superlist
                }
            } else if second_list
                .windows(first_list.len())
                .any(|sublist| sublist == first_list)
            {
                Comparison::Sublist
            } else {
                Comparison::Unequal
            }
        }
    }
}
