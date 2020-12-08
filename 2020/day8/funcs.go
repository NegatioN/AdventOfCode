package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
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

type computerError struct {
	s string
}
func (e *computerError) Error() string {
	return e.s
}

type Computer struct {
	Accumulator int
	Pointer int
	Instructions []string
	Visited map[int]int
}

func (c *Computer) visit(i int) bool {
	_, exists := c.Visited[i]
	c.Visited[i] = 0
	return exists
}

func toPair(text string) (string, int) {
	data := strings.Split(text, " ")
	num, _ := strconv.Atoi(data[1])
	return data[0], num
}

func (c *Computer) executeInstruction() (bool, error) {
	if c.Pointer == len(c.Instructions) {
		return true, nil
	}

	if c.Pointer >= len(c.Instructions) {
		return false, &computerError{fmt.Sprintf("Have only: %v instructions, but pointer at: %v", len(c.Instructions), c.Pointer)}
	}

	seen := c.visit(c.Pointer)
	if seen {
		return false, &computerError{fmt.Sprintf("Instruction %v has already been visited. Accumulator: %v", c.Pointer, c.Accumulator)}
	}

	instruction, num := toPair(c.Instructions[c.Pointer])
	switch instruction {
	case "acc":
		c.Accumulator += num
		c.Pointer += 1
	case "jmp":
		c.Pointer += num
	default:
		c.Pointer += 1
	}

	return false, nil
}


func ParseInput(texts []string) (Computer, error) {
	return Computer{0, 0, texts, make(map[int]int)}, nil
}

func copyArray(a []string) []string {
	cpy := make([]string, len(a))
	copy(cpy, a)
	return cpy
}

func ParseVariants(texts []string) [][]string {
	out := make([][]string, 0)
	for i, text := range texts {
		instruction, num := toPair(text)

		if instruction == "nop"{
			c := copyArray(texts)
			c[i] = fmt.Sprintf("jmp %v", num)
			out = append(out, c)
		}
		if instruction == "jmp"{
			c := copyArray(texts)
			c[i] = fmt.Sprintf("nop %v", num)
			out = append(out, c)
		}
	}
	return out
}
