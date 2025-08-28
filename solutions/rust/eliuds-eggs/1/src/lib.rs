use core::arch::asm;
pub fn egg_count(display_value: u32) -> usize {
    if cfg!(any(target_arch = "x86", target_arch = "x86_64")) {
        let result: u32;
        unsafe {
            asm!("popcnt {:e}, {:e}", out(reg) result, in(reg) display_value)
        };
        result as usize
    } else {
        unimplemented!()
    }
}
