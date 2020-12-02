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

type Password struct {
	RequiredLetter rune
	MinimumCount int
	MaximumCount int
	Text string
}

func newPassword(textLine string) *Password{
	s := strings.Split(textLine, ":")
	lastEl := len(s[0]) - 1
	counts := strings.Split(s[0][:lastEl], "-")
	mc, _ := strconv.Atoi(strings.Trim(counts[0], " "))
	hc, _ := strconv.Atoi(strings.Trim(counts[1], " "))
	return &Password{rune(s[0][lastEl]), mc, hc, strings.Trim(s[1], " ")}
}

func (p *Password) validateStandard() bool {
	c := 0
	for _, letter := range p.Text {
		if letter == p.RequiredLetter {
			c += 1
		}
		if c > p.MaximumCount {
			return false
		}
	}
	return c >= p.MinimumCount
}

func (p *Password) validateSecond() bool {
	hasLetter := rune(p.Text[p.MinimumCount - 1]) == p.RequiredLetter || rune(p.Text[p.MaximumCount - 1]) == p.RequiredLetter
	notLetter := rune(p.Text[p.MinimumCount - 1]) != p.RequiredLetter || rune(p.Text[p.MaximumCount - 1]) != p.RequiredLetter
	return hasLetter && notLetter
}


func main() {
	lines, _ := readLines("../data/day2")
	c := 0
	c2 := 0
	for _, el := range lines {
		pw := newPassword(el)
		if pw.validateStandard() {
			c += 1
		}
		if pw.validateSecond() {
			c2 += 1
		}
	}

	fmt.Println(c)
	fmt.Println(c2)
}
