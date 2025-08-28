#[macro_export]
macro_rules! hashmap {
    () => {
        ::std::collections::HashMap::new()
    };
    ($($x:expr=>$y:expr),+ $(,)?) => {
        ::std::collections::HashMap::from([$(($x, $y)),*])
    }
}
