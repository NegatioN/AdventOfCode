package main

import (
	"bufio"
	"fmt"
	"os"
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

type World struct {
	Spaces [][]int
	MaxX int
}

func parseWorld(texts []string) *World{
	d := make([][]int, len(texts))
	for i, l := range texts {
		ls := make([]int, len(l))
		for j, c := range l {
			if c == '#' {
				ls[j] = 1
			}
		}
		d[i] = ls
	}
	return &World{d, len(d[0])}
}

func (w *World) traverse(xStep, yStep int) int {
	c := 0
	x := 0
	y := 0
	for y < len(w.Spaces) - 1 {
		x += xStep
		x = x % w.MaxX
		y += yStep

		c += w.Spaces[y][x]
	}
	return c
}


func main() {
	lines, _ := readLines("../data/day3")
	world := parseWorld(lines)

	p1 := world.traverse(3, 1)
	fmt.Println(p1)

	p2_1 := world.traverse(1, 1)
	p2_2 := world.traverse(5, 1)
	p2_3 := world.traverse(7, 1)
	p2_4 := world.traverse(1,2)

	fmt.Println(p1 * p2_1 * p2_2 * p2_3 * p2_4)
}
