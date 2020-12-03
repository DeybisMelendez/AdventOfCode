package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"strings"
	"time"
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
		view(input, pos.x, pos.y)
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

func clear() {
	cmd := exec.Command("clear") //Linux
	cmd.Stdout = os.Stdout
	cmd.Run()
}

func view(input []string, x int, y int) {
	for i := -10; i <= 10; i++ {
		if i+y > 0 && i+y < len(input) {
			for j := 0; j < 31; j++ {
				if i == 0 && j == x {
					fmt.Print(string("\033[31m"), "@")
				} else if string(input[i+y][j]) == "#" {
					fmt.Print(string("\033[32m"), "#")
				} else {
					fmt.Print(string("\033[37m"), ".")
				}
			}
			fmt.Print("\n")
		}
	}
	time.Sleep(100 * time.Millisecond)
	clear()
}

func main() {
	input, _ := ioutil.ReadFile("03input.txt")
	fmt.Println(answer1(string(input), 3, 1))
	fmt.Println(answer2(string(input)))
}
