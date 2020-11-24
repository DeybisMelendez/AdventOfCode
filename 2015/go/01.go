package main

import (
	"fmt"
	"io/ioutil"
)

func answer1(input string) int {
	var result int = 0
	for _, char := range input {
		c := string(char)
		if c == "(" {
			result++
		} else if c == ")" {
			result--
		}
	}
	return result
}

func answer2(input string) int {
	var floor int = 0
	for pos, char := range input {
		c := string(char)
		if c == "(" {
			floor++
		} else if c == ")" {
			floor--
		}
		if floor == -1 {
			return pos + 1
		}
	}
	return 0
}

func main() {
	data, _ := ioutil.ReadFile("01input.txt")
	text := string(data)
	fmt.Println(answer1(text))
	fmt.Println(answer2(text))
}
