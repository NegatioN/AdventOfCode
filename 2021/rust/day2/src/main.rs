use std::fs;

fn main() {
    let filename = "../../data/day2";
    let content = fs::read_to_string(filename).expect("Something went wrong");
    let input: Vec<Vec<&str>> =  content
        .lines()
        .map(|n| n.split(" ").collect::<Vec<&str>>())
        .collect();

    let mut horiz = 0;
    let mut depth = 0;
    for x in input{
        let dist = x[1].parse::<u32>().expect("Bug");
        match x[0] {
            "forward" =>horiz+=dist,
            "down" =>depth+=dist,
            "up" =>depth-=dist,
            _=>println!("nothing")
        }
    }
    println!("{}", horiz*depth);
}
