#[macro_export]
macro_rules! hashmap {
    () => {
        ::std::collections::HashMap::new()
    };
    ($($x:expr=>$y:expr),+ $(,)?) => {
        ::std::collections::HashMap::from([$(($x, $y)),*])
    }
}

/// This module contains doctests, which allows writing tests where a code
/// snippet is supposed to fail to compile. These tests also have "ignore"
/// attributes, make sure to remove them when solving this exercise locally.
pub mod compile_fail_tests;
