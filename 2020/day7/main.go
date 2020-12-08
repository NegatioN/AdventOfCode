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

func parseForms(texts []string) Rules {
	rules := make(map[string]map[string]int)
	for _, l := range texts {
		a := strings.Split(l, " bags contain ")
		finalRes := strings.Split(a[1][:len(a[1])-1], " ")

		aRule := make(map[string]int)
		for i, _ := range finalRes {
			w := finalRes[i]
			if w == "bag" || w == "bags" || w == "bag," || w == "bags," {
				name := strings.Join(finalRes[i-2:i], " ")
				if name == "no other" {
					continue
				}
				num, _ := strconv.Atoi(finalRes[i-3])
				aRule[name] = num
			}
		}
		rules[a[0]] = aRule
	}

	return Rules{rules}
}

type Rules struct {
	Rule map[string]map[string]int
}

func (r *Rules) canHold(name string) map[string]int {
	a := make(map[string]int)
	for key, value := range r.Rule {
		_, hasKey := value[name]
		if hasKey {
			a[key] = 1
		}
	}

	for k, _ := range a {
		m := r.canHold(k)
		for kk, _ := range m {
			a[kk] = 1
		}
	}

	return a
}

func (r *Rules) held(name string) map[string]int {
	a := make(map[string]int)
	for key, value := range r.Rule[name] {
		a[key] = value
	}

	for k, v := range a {
		m := r.held(k)
		for _, vv := range m {
			a[k] += v * vv
		}
	}

	return a
}

func (r *Rules) numHolds(name string) int {
	return len(r.canHold(name))
}

func (r *Rules) bagsIn(name string) int {
	c := 0
	for _, v := range r.held(name) {
		c += v
	}
	return c
}

func main() {
	lines, _ := readLines("../data/day7")
	bagRules := parseForms(lines)
	fmt.Println(bagRules.numHolds("shiny gold"))
	fmt.Println(bagRules.bagsIn("shiny gold"))
}