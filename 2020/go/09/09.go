package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func getInput(inputStr string) []string {
	return strings.Split(inputStr, "\n")
}

func answer1(inputStr string, index int) int {
	input := getInput(inputStr)
	for len(input) >= index {
		nums := input[:index]
		value, _ := strconv.Atoi(input[index])
		isEqual := false
	out:
		for i, v := range nums {
			for i2, v2 := range nums {
				if i > i2 {
					num1, _ := strconv.Atoi(v)
					num2, _ := strconv.Atoi(v2)
					//fmt.Println(num1, num2, num1+num2, value)
					if num1+num2 == value {
						isEqual = true
						break out
					}
				} else {
					break
				}
			}
		}
		if !isEqual {
			return value
		}
		input = input[1:]
	}
	return -1
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Println(answer1(string(input), 25))
	//fmt.Println(answer2(string(input)))
}
