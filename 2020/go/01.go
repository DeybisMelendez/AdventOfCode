package main

import (
	"io/ioutil"
	"regexp"
	"strconv"
)

func getInput(input string) []string {
	regex := regexp.MustCompile("(\\d+)")
	return regex.FindAllString(input, -1)
}

func answer1(inputStr string) int {
	input := getInput(inputStr)
	for i1, v1 := range input {
		for i2, v2 := range input {
			if i1 != i2 {
				val1, _ := strconv.Atoi(v1)
				val2, _ := strconv.Atoi(v2)
				if val1+val2 == 2020 {
					return val1 * val2
				}
			}
		}
	}
	return -1
}

func answer2(inputStr string) int {
	input := getInput(inputStr)
	for i1, v1 := range input {
		for i2, v2 := range input {
			for i3, v3 := range input {
				if i1 != i2 && i1 != i3 {
					val1, _ := strconv.Atoi(v1)
					val2, _ := strconv.Atoi(v2)
					val3, _ := strconv.Atoi(v3)
					if val1+val2+val3 == 2020 {
						return val1 * val2 * val3
					}
				}
			}
		}
	}
	return -1
}
func main() {
	input, _ := ioutil.ReadFile("01input.txt")
	println(answer1(string(input)))
	println(answer2(string(input)))
}
