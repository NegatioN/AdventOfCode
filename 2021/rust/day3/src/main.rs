use std::fs;

fn bools_to_dec(inp: &Vec<bool>) -> u32 {
    let mut n = 0;
    for (i, ind) in (0..inp.len()).rev().enumerate() {
        n += (inp[ind] as u32) * 2_u32.pow(i as u32);
    }
    n
}
fn main() {
    let filename = "../../data/day3";
    let content = fs::read_to_string(filename).expect("Something went wrong");
    let input: Vec<Vec<u32>> = content
        .split_whitespace()
        .map(|n| n.chars().map(|c| c.to_digit(2).expect("Error")).collect())
        .collect();
    let c = input.concat();

    const BIN_NUMS: usize = 12;
    let rows = c.len() / BIN_NUMS;
    let mut scores: [u32; BIN_NUMS] = [0; BIN_NUMS];
    for j in 0..rows {
        for i in 0..BIN_NUMS {
            scores[i] += c[i+(j*BIN_NUMS)];
        }
    }
    let half_rows : u32 = rows as u32/ 2;
    let gamma: Vec<bool> = scores.iter().map(|x| x >= &half_rows).collect();
    let epsilon: Vec<bool> = gamma.iter().map(|x| !x).collect();
    println!("{}", bools_to_dec(&gamma) * bools_to_dec(&epsilon));
}
