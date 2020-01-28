use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    p1();
    p2();
}

fn p1() {
    let data = get_input("src/input.txt");
    let ans: f32 = data.iter().map(|f| (*f / 3.0).floor() - 2.0).sum();
    println!("{}", ans)
}

fn p2() {
    let data = get_input("src/input.txt");
    let mut ans: f32 = 0.0;
    let (mut fuel, mut curr_mass): (f32, f32);

    for mass in data.iter() {
        curr_mass = *mass;

        while curr_mass > 6.0 {
            fuel = (curr_mass / 3.0).floor() - 2.0;
            ans += fuel;
            curr_mass = fuel;
        }
    }
    println!("{}", ans)
}

fn get_input(filename: &str) -> Vec<f32> {
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);

    return reader
        .lines()
        .map(|l| l.unwrap().parse::<f32>().unwrap())
        .collect();
}
