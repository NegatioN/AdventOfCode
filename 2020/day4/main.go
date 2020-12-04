package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"regexp"
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

type Passport struct {
	Cid string
	Byr int `json:",string"`
	Eyr int `json:",string"`
	Iyr int `json:",string"`
	Hgt string
	Hcl string
	Ecl string
	Pid string
	numFields int
}

func (p *Passport) validate() bool {
	return (p.Cid != "" && p.numFields == 8) || (p.Cid == "" && p.numFields > 6)
}

func (p *Passport) validate2() bool {
	if p.validate() {
		byr := p.Byr <= 2002 && p.Byr >= 1920
		iyr := p.Iyr <= 2020 && p.Iyr >= 2010
		eyr := p.Eyr <= 2030 && p.Eyr >= 2020
		hCutoff := len(p.Hgt) - 2
		h, _ := strconv.Atoi(p.Hgt[:hCutoff])
		var hgt bool
		if p.Hgt[hCutoff:] == "cm" {
			hgt = h >= 150 && h <= 193
		} else {
			hgt = h >= 59 && h <= 76
		}


		hcl, _ := regexp.MatchString("^#[a-f|0-9]{6}$", p.Hcl)
		pid, _ := regexp.MatchString("^[0-9]{9}$", p.Pid)
		ecl, _ := regexp.MatchString("^amb|blu|brn|gry|grn|hzl|oth$", p.Ecl)

		return byr && iyr && eyr && hgt && hcl && ecl && pid
	}
	return false
}


func parsePassports(texts []string) []*Passport {
	pps := make([]*Passport, 0)

	current_entry := make([]string, 0)
	for _, l := range texts {
		if l == "" {
			s := strings.Join(current_entry, " ")
			sa := strings.Split(s, " ")
			m := make(map[string]string)

			for _, se := range sa {
				el := strings.Split(se, ":")
				m[el[0]] = el[1]
			}
			jsonString, _ := json.Marshal(m)
			var p Passport
			json.Unmarshal(jsonString, &p)
			p.numFields = len(m)
			pps = append(pps, &p)

			current_entry = make([]string, 0)
		} else {
			current_entry = append(current_entry, l)
		}
	}
	return pps
}



func main() {
	lines, _ := readLines("../data/day4")
	passports := parsePassports(lines)
	c := 0
	for _, p := range passports {
		if p.validate2() {
			c+= 1
		}
	}

	fmt.Println(c)
}
