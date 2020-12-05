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

func answer1(input string, x int, y int) int {
	input = strings.Replace(input, "\n", "", -1)
	pos := vec{0, 0}
	trees := 0
	for pos.y*31+pos.x < len(input)-1 {
		if string(input[pos.y*31+pos.x]) == "#" {
			trees++
		}
		pos.x += x
		pos.y += y
		if pos.x > 30 {
			pos.x -= 31
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
