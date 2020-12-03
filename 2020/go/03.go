package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type vec struct {
	x int
	y int
}

func answer1(inputStr string, x int, y int) int {
	input := strings.Split(inputStr, "\n")
	pos := vec{0, 0}
	trees := 0
	for pos.y+1 < len(input) {
		pos.x += x
		pos.y += y
		if pos.x > 30 {
			pos.x -= 31
		}
		if string(input[pos.y][pos.x]) == "#" {
			trees++
		}
	}
	return trees
}

func answer2(input string) int {
	a := answer1(input, 1, 1)
	b := answer1(input, 3, 1)
	c := answer1(input, 5, 1)
	d := answer1(input, 7, 1)
	e := answer1(input, 1, 2)
	return a * b * c * d * e
}

func main() {
	input, _ := ioutil.ReadFile("03input.txt")
	fmt.Println(answer1(string(input), 3, 1))
	fmt.Println(answer2(string(input)))
}
