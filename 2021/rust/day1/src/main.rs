use std::fs;
fn main() {
    let filename = "../../data/day1";
    let content = fs::read_to_string(filename).expect("Something went wrong");
    let nums: Vec<u32> = content
        .split_whitespace()
        .map(|n| n.parse().expect("parse error"))
        .collect();

    let larger_than_prev: u32 = nums[1..]
        .iter()
        .zip(nums[..nums.len() - 1].iter())
        .map(|(x, y)| (x > y) as u32)
        .sum();
    println!("{}", larger_than_prev);

    let mut part2: u32 = 0;
    for i in 1..nums.len()-2 {
        part2 += (nums[i-1] < nums[i+2]) as u32;
    }
    println!("{}", part2);
}
