package main

import (
	"io/ioutil"
	"regexp"
	"strconv"
)

func getInput(input string) [][]string {
	regex := regexp.MustCompile("(\\d+)-(\\d+) (\\w): (\\w+)")
	return regex.FindAllStringSubmatch(input, -1)
}

func isValid(from int, to int, letter string, pass string) bool {
	countChar := 0
	for _, r := range pass {
		c := string(r)
		if c == letter {
			countChar++
		}
	}
	if countChar >= from && countChar <= to {
		return true
	}
	return false
}

func isValid2(i1 int, i2 int, letter string, pass string) bool {
	a := string(pass[i1-1]) == letter && string(pass[i2-1]) != letter
	b := string(pass[i2-1]) == letter && string(pass[i1-1]) != letter
	return a || b
}

func answer1(inputStr string) int {
	input := getInput(inputStr)
	result := 0
	for _, v := range input {
		from, _ := strconv.Atoi(v[1])
		to, _ := strconv.Atoi(v[2])
		letter := v[3]
		pass := v[4]
		if isValid(from, to, letter, pass) {
			result++
		}
	}
	return result
}

func answer2(inputStr string) int {
	input := getInput(inputStr)
	result := 0
	for _, v := range input {
		i1, _ := strconv.Atoi(v[1])
		i2, _ := strconv.Atoi(v[2])
		letter := v[3]
		pass := v[4]
		if isValid2(i1, i2, letter, pass) {
			result++
		}
	}
	return result
}
func main() {
	input, _ := ioutil.ReadFile("02input.txt")
	println(answer1(string(input)))
	println(answer2(string(input)))
}
