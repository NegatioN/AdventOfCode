use std::fs;
use std::time::{Instant};

fn summator(arr: &Vec<u32>, cmp_offset: usize) -> u32 {
    let s = arr
        .iter()
        .zip(arr[cmp_offset+1..].iter())
        .map(|(x, y)| (x < y) as u32)
        .sum();
    s
}

fn main() {
    let filename = "../../data/day1";
    let content = fs::read_to_string(filename).expect("Something went wrong");
    let nums: Vec<u32> = content
        .split_whitespace()
        .map(|n| n.parse().expect("parse error"))
        .collect();

    let start = Instant::now();
    println!("{}", summator(&nums, 0));
    let duration = start.elapsed();
    println!("{}", summator(&nums, 2));
    println!("Time elapsed in summator() is: {:?}", duration);
}
