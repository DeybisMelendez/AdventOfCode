package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func contains(s []int, e int) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func getInput(inputStr string) []string {
	return strings.Split(inputStr, "\n") // windows \r linux \n
}

func lowerHalf(a int, b int) int {
	return ((b - a + 1) / 2) - 1 + a
}

func upperHalf(a int, b int) int {
	return (b-a+1)/2 + a
}
func answer2(inputStr string) int {
	input := getInput(inputStr)
	var seatIds []int
	for _, value := range input {
		fY, bY := 0, 127
		lX, rX := 0, 7
		for _, r := range value {
			c := string(r)
			//fmt.Println(c)
			switch c {
			case "F":
				bY = lowerHalf(fY, bY)
			case "B":
				fY = upperHalf(fY, bY)
			case "R":
				lX = upperHalf(lX, rX)
			case "L":
				rX = lowerHalf(lX, rX)
			}
			//fmt.Println(fY, bY, lX, rX)
		}
		var col, row int
		if fY > bY {
			row = fY
		} else {
			row = bY
		}
		if lX > rX {
			col = lX
		} else {
			col = rX
		}
		id := row*8 + col
		seatIds = append(seatIds, id)
	}

	for i := 0; i < 128*8; i++ {
		if contains(seatIds, i+1) && contains(seatIds, i-1) && !contains(seatIds, i) {
			return i
		}
	}
	return -1
}
func answer1(inputStr string) int {
	input := getInput(inputStr)
	best := 0
	for _, value := range input {
		fY, bY := 0, 127
		lX, rX := 0, 7
		for _, r := range value {
			c := string(r)
			//fmt.Println(c)
			switch c {
			case "F":
				bY = lowerHalf(fY, bY)
			case "B":
				fY = upperHalf(fY, bY)
			case "R":
				lX = upperHalf(lX, rX)
			case "L":
				rX = lowerHalf(lX, rX)
			}
			//fmt.Println(fY, bY, lX, rX)
		}
		var col, row int
		if fY > bY {
			row = fY
		} else {
			row = bY
		}
		if lX > rX {
			col = lX
		} else {
			col = rX
		}
		result := row*8 + col
		if result > best {
			best = result
		}
	}
	return best
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Println(answer1(string(input)))
	fmt.Println(answer2(string(input)))
}
