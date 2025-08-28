pub fn is_leap_year(year: u64) -> bool {
    year.rem_euclid(400) == 0 || year.rem_euclid(100) != 0 && year.rem_euclid(4) == 0
}
