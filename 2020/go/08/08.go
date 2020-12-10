package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
)

func contains(s []int, e int) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func getInput(inputStr string) [][]string {
	regex := regexp.MustCompile("(\\w+) ([\\+\\-]\\d+)")
	return regex.FindAllStringSubmatch(inputStr, -1)
}

func answer1(inputStr string) int {
	input := getInput(inputStr)
	exe := true
	pointer := 0
	accumulator := 0
	visited := []int{}
	for exe {
		key := input[pointer][1]
		value, _ := strconv.Atoi(input[pointer][2])
		switch key {
		case "acc":
			accumulator += value
			pointer++
		case "jmp":
			pointer += value
		default:
			pointer++
		}
		if contains(visited, pointer) {
			exe = false
		} else {
			visited = append(visited, pointer)
		}
	}
	return accumulator
}
func answer2(inputStr string) int {
	indexToChange := []int{}
	accumulator := 0
	for i, v := range getInput(inputStr) {
		value := v[1]
		if value == "jmp" || value == "nop" {
			indexToChange = append(indexToChange, i)
		}
	}
	for _, v := range indexToChange {
		accumulator = 0
		input := getInput(inputStr)
		exe := true
		pointer := 0
		visited := []int{}
		switch input[v][1] {
		case "jmp":
			input[v][1] = "nop"
		case "nop":
			input[v][1] = "jmp"
		}
		for exe {
			key := input[pointer][1]
			value, _ := strconv.Atoi(input[pointer][2])
			switch key {
			case "acc":
				accumulator += value
				pointer++
			case "jmp":
				pointer += value
			default:
				pointer++
			}
			if contains(visited, pointer) {
				exe = false
			} else if pointer >= len(input) {
				break
			} else {
				visited = append(visited, pointer)
			}
		}
		if exe {
			break
		}
	}
	return accumulator
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Println(answer1(string(input)))
	fmt.Println(answer2(string(input)))
}
