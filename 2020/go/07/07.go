package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func getInput(inputStr string) []string {
	inputStr = strings.ReplaceAll(inputStr, " bags contain", ",")
	inputStr = strings.ReplaceAll(inputStr, " bags", "")
	inputStr = strings.ReplaceAll(inputStr, " bag", "")
	inputStr = strings.ReplaceAll(inputStr, ".", "")
	return strings.Split(inputStr, "\n")
}

func getParams(params string) []string {
	//params = strings.Trim(params, " ")
	return strings.Split(params, ",")
}
func answer1(inputStr string) int {
	input := getInput(inputStr)
	//fmt.Println(input)
	rules := make(map[string][]string)
	total := 0
	for _, v := range input {
		params := getParams(v)
		bag := params[0]
		rule := []string{}
		params = params[1:]
		for len(params) > 1 {
			params = params[1:]
			item := strings.Split(params[0], " ")
			rule = append(rule, item[2]+item[3])
			fmt.Println(item[2] + item[3])
			params = params[1:]
		}
		rules[bag] = rule
	}
	return total
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Println(answer1(string(input)))
	//fmt.Println(answer2(string(input)))
}
