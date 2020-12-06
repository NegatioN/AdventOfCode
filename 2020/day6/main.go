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

func parseForms(texts []string) []Group {
	groups := make([]Group, 0)
	current_entry := make([]string, 0)
	for _, l := range texts {
		if l == "" {
			groups = append(groups, NewGroup(current_entry))
			current_entry = make([]string, 0)
		} else {
			current_entry = append(current_entry, l)
		}
	}
	return groups
}

func NewGroup(lines []string) Group {
	forms := make([]map[rune]bool, 0)
	for _, l := range lines {
		f := make(map[rune]bool)
		for _, c := range l {
			f[c] = true
		}
		forms = append(forms, f)
	}
	return Group{Forms: forms}
}

type Group struct {
	Forms []map[rune]bool
}

func dostuff(condition bool) func(*Group, rune) bool {
	return func(g *Group, letter rune) bool {
		for _, f := range g.Forms {
			if f[letter] == condition {
				return condition
			}
		}
		return !condition
	}
}

func (g *Group) countAnswers(f func(*Group, rune) bool) int {
	c := 0
	for i := 97; i < 97+26; i++ {
		if f(g, rune(i)) {
			c += 1
		}
	}
	return c
}

func main() {
	lines, _ := readLines("../data/day6")
	groups := parseForms(lines)
	c := 0
	for _, group := range groups {
		c += group.countAnswers(dostuff(true))
	}
	fmt.Println(c)
	c = 0
	for _, group := range groups {
		c += group.countAnswers(dostuff(false))
	}
	fmt.Println(c)
}