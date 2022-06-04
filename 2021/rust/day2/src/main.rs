use std::fs;

fn calculate(input: &Vec<Vec<&str>>) -> (i32, i32, i32) {
    let mut horiz:i32 = 0;
    let mut depth: i32 = 0;
    let mut aim: i32 = 0;
    for x in input {
        let dist: i32 = x[1].parse().expect("Bug");
        match x[0] {
            "forward" => {
                horiz += dist;
                depth += (aim * dist)
            }
            "down" => aim += dist,
            "up" => aim -= dist,
            _ => println!("nothing"),
        }
    }
    (horiz, depth, aim)
}
fn main() {
    let filename = "../../data/day2";
    let content = fs::read_to_string(filename).expect("Something went wrong");
    let input: Vec<Vec<&str>> = content
        .lines()
        .map(|n| n.split(" ").collect::<Vec<&str>>())
        .collect();

    let res = calculate(&input);
    println!("{}", res.0*res.2);
    let res = calculate(&input);
    println!("{}", res.0*res.1);
}
