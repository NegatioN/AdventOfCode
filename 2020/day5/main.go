package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
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

type Ticket struct {
	Rows BSP
	Seats BSP
	Sequence []rune
}

type BSP struct {
	LeftNum    int
	RightNum   int
	CurrentNum int
	LeftRune rune
}

func NewBSP(end int, leftrune rune) BSP {
	return BSP{0, end, end/2, leftrune}
}

func (b *BSP) traverse(letter rune) {
	if letter == b.LeftRune {
		b.RightNum = b.CurrentNum
	} else {
		b.LeftNum = b.CurrentNum+1
	}
	b.CurrentNum = (b.RightNum + b.LeftNum ) / 2
}

func (t *Ticket) Id() int {
	for _, r := range t.Sequence[:7] {
		t.Rows.traverse(r)
	}
	for _, r := range t.Sequence[7:] {
		t.Seats.traverse(r)
	}
	return t.Rows.CurrentNum * 8 + t.Seats.CurrentNum
}

func parseTicket(text string) *Ticket {
	return &Ticket{NewBSP(127, 'F'), NewBSP(7, 'L'), []rune(text)}
}

func main() {
	lines, _ := readLines("../data/day5")
	c := 0
	ids := make([]int, 800)
	for i, l := range lines {
		t := parseTicket(l)
		id := t.Id()
		ids[i] = id
		if id > c {
			c = id
		}
	}

	sort.Ints(ids)
	fmt.Println(c)
	c = 0
	for _, i := range ids {
		if c == 0 {
			c = i
			continue
		}
		if c == i || c + 1 == i {
			c = i
		} else {
			fmt.Println(c+1)
			break
		}
	}
}
