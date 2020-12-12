package main

import (
	"bufio"
	"math"
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

func ValidNumber(sequence []int) bool{
	lastIndex := len(sequence) - 1

	testables := sequence[:lastIndex]
	checkNum := sequence[lastIndex]
	for i := range testables {
		for j := range testables {
			if i != j {
				if testables[i] + testables[j] == checkNum {
					return true
				}
			}
		}
	}
	return false
}

func FirstOffender(sequence []int, numPreamble int) int {
	i := numPreamble + 1
	s := 0

	for i < len(sequence) {
		if !ValidNumber(sequence[s:i]) {
			return sequence[i-1]
		}
		i += 1
		s += 1
	}

	return -1
}

func MinMax(sequence []int) (int, int) {
	var min, max = math.MaxInt32, math.MinInt32
	for _, val := range sequence {
		if val > max {
			max = val
		}
		if val < min {
			min = val
		}
	}
	return min, max
}

func Sum(input ...int) int {
	sum := 0
	for i := range input {
		sum += input[i]
	}
	return sum
}

func FindWeakSubsequence(testNum int, sequence ...int) []int {
	var start, end = 0, 2

	for end < len(sequence) {
		for start < end - 1 {
			if testNum == Sum(sequence[start:end]...) {
				return sequence[start:end]
			}
			start += 1
		}
		start = 0
		end += 1
	}

	return []int{}
}
