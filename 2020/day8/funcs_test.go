package main

import (
"testing"
)

func TestParse(t *testing.T) {
	lines, _ := readLines("../data/day8test")
	computer, err := ParseInput(lines)
	if err != nil {
		t.Errorf("Couldnt create computer")
	}

	if len(computer.Instructions) != len(lines) {
		t.Errorf("Didnt parse all lines")
	}
}

func TestExecuteOutofbounds(t *testing.T) {
	computer := Computer{ 0,10, []string{}, make(map[int]int)}

	_, err := computer.executeInstruction()
	if err == nil {
		t.Errorf("Error doesnt propagate")
	}
}

func TestExecute(t *testing.T) {
	computer, _ := ParseInput([]string{"nop +0"})

	_, err := computer.executeInstruction()
	if err == nil {
		t.Errorf("Error doesnt propagate")
	}
}
