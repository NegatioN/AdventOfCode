use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    let data = get_input("src/input.txt");
    let mut ans: i32 = 0;
    for mass in data.iter() {
        ans += ((*mass / 3.0).floor() - 2.0) as i32
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
