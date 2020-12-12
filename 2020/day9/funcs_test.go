package main

import (
	"testing"
)

func TestValidNumber(t *testing.T) {
	data := []int{35,20,15,25,47,40}
	res := ValidNumber(data)
	if !res {
		t.Errorf("%v should be valid sequence", data)
	}
}

func TestFirstOffender(t *testing.T) {
	data := []int{35,20,15,25,47,40,62,55,65,95,102,117,150,182,127,219,299,277,309,576}

	res := FirstOffender(data, 5)

	if res != 127{
		t.Errorf("127 should be first offender, but was %v", res)
	}
}

func TestMinMax(t *testing.T) {
	data := []int{35,20,15,25,47,40}

	min, max := MinMax(data)

	if min != 15 || max != 47{
		t.Errorf("MinMax should be (15,47) but was (%v,%v)", min, max)
	}
}

func TestFindWeakSubsequence(t *testing.T) {
	data := []int{35,20,15,25,47,40,62,55,65,95,102,117,150,182,127,219,299,277,309,576}
	ans := []int{15,25,47,40}

	res := FindWeakSubsequence(127, data...)

	if len(res) != len(ans) {
		t.Errorf("Number of elements should be %v, was %v", len(ans), len(res))
	}

	var correctElements = true
	for i := range res {
		if res[i] != ans[i] {
			correctElements = false
		}
	}

	if !correctElements {
		t.Errorf("Answer should be %v, was %v", ans, res)
	}

}

func TestSum(t *testing.T) {
	if Sum(5, 6) != 5 + 6{
		t.Errorf("Sum should be 11, was %v", Sum(5, 6))
	}

	if Sum(5, 6, 99) != 5 + 6 + 99{
		t.Errorf("Sum should be 110, was %v", Sum(5, 6, 99))
	}
}
