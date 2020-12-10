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

func min(s []string) int {
	result, _ := strconv.Atoi(s[0])
	s = s[1:]
	for _, v := range s {
		val, _ := strconv.Atoi(v)
		if result > val {
			result = val
		}
	}
	return result
}

func max(s []string) int {
	result, _ := strconv.Atoi(s[0])
	s = s[1:]
	for _, v := range s {
		val, _ := strconv.Atoi(v)
		if result < val {
			result = val
		}
	}
	return result
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

func answer2(inputStr string, index int) int {
	target := answer1(inputStr, index)
	input := getInput(inputStr)
	i := 1
	total := 0
	sums := []string{}
	for total != target {
		sums = input[0:i]
		for _, v := range sums {
			val, _ := strconv.Atoi(v)
			total += val
		}
		if total > target {
			input = input[1:]
			i = 1
			total = 0
		} else if total < target {
			i++
			total = 0
		}
	}
	//fmt.Println(sums, min(sums), max(sums))
	return min(sums) + max(sums)
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	preamble := 25
	fmt.Println(answer1(string(input), preamble))
	fmt.Println(answer2(string(input), preamble))
}
