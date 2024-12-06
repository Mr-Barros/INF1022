#[allow(unused_mut)]
#[allow(unused_variables)]
fn main() {
    let mut total: u32 = 0;
    let mut incremento: u32 = 1;
    let mut numvezes: u32 = 9;
    if numvezes > 5 || 1 > 2 {
        for _i in 0..numvezes {
            if incremento < 6 {
                incremento += 1;
            } else {
                incremento += 2;
            }
            total += incremento;
            println!("{}", 2 + incremento);
        }
    }
    println!("{}", total);
}
