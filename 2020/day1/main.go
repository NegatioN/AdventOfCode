package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

func findtwentytwenty(numbers []int) int {
	for _, el1 := range numbers {
		for _, el2 := range numbers {
			if el1 + el2 == 2020 {
				return el1*el2
			}
		}
	}
	return -1
}

func findtwentytwentytwenty(numbers []int) int {
	for _, el1 := range numbers {
		for _, el2 := range numbers {
			for _, el3 := range numbers {
				if el1 + el2 + el3 == 2020 {
					return el1*el2*el3
				}
			}
		}
	}
	return -1
}

func main() {
	lines, _ := readLines("../data/day1")
	numbers := make([]int, len(lines))
	for i, el := range lines {
		e, _ := strconv.Atoi(el)
		numbers[i] = e
	}

	fmt.Println(findtwentytwenty(numbers))
	fmt.Println(findtwentytwentytwenty(numbers))

}
