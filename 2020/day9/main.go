package main

import (
	"fmt"
	"strconv"
)

func main() {
	lines, _ := readLines("../data/day9")

	a := make([]int, 0)
	for _, l := range lines {
		i, _ := strconv.Atoi(l)
		a = append(a, i)
	}

	ans1 := FirstOffender(a, 25)
	fmt.Println(ans1)

	sub := FindWeakSubsequence(ans1, a...)
	min, max := MinMax(sub)

	ans2 := min + max
	fmt.Println(ans2)
}
