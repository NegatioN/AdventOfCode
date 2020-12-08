package main

import "fmt"

func main() {
	lines, _ := readLines("../data/day8")
	computer, _ := ParseInput(lines)

	var err error
	var success bool
	err = nil
	for err == nil && !success {
		success, err = computer.executeInstruction()
	}
	fmt.Println(err)


	for _, variant := range ParseVariants(lines) {
		computer, _ = ParseInput(variant)
		err = nil
		success = false
		for err == nil && !success {
			success, err = computer.executeInstruction()
		}
		if success {
			fmt.Println(computer.Accumulator)
		}
	}

}
