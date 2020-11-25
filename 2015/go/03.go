package main

import (
	"fmt"
	"io/ioutil"
)

type vec struct {
	x int
	y int
}

func contains(s []vec, e vec) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func answer1(input string) int {
	santa := vec{0, 0}
	visited := []vec{santa}
	for _, char := range input {
		c := string(char)
		switch c {
		case "^":
			santa.y++
		case "v":
			santa.y--
		case ">":
			santa.x++
		case "<":
			santa.x--
		}
		value := vec{santa.x, santa.y}
		if !contains(visited, value) {
			visited = append(visited, value)
		}
	}
	return len(visited)
}

func answer2(input string) int {
	santa := vec{0, 0}
	robot := vec{0, 0}
	turn := true
	visited := []vec{santa}
	for _, char := range input {
		c := string(char)
		var actual *vec
		if turn {
			actual = &santa
		} else {
			actual = &robot
		}
		switch c {
		case "^":
			actual.y++
		case "v":
			actual.y--
		case ">":
			actual.x++
		case "<":
			actual.x--
		}
		if !contains(visited, *actual) {
			visited = append(visited, *actual)
		}
		turn = !turn
	}
	return len(visited)
}

func main() {
	data, _ := ioutil.ReadFile("03input.txt")
	text := string(data)
	fmt.Println(answer1(text))
	fmt.Println(answer2(text))
}
