#[allow(unused_mut)]
#[allow(unused_variables)]
fn main() {
    let mut resultado: u32 = 1;
    for _i in 0..3 {
        resultado *= 2;
    }
    println!("{}", resultado);
}
