package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

const TURN_ON uint8 = 0
const TURN_OFF uint8 = 1
const TOGGLE uint8 = 2

var line *regexp.Regexp = regexp.MustCompile("\n+")

// var spaces *regexp.Regexp = regexp.MustCompile("%s+")
var commas *regexp.Regexp = regexp.MustCompile(",+")
var grid [1000][1000]bool
var grid2 [1000][1000]int

func lightConfig(config uint8, xOrigin int, yOrigin int, xTarget int, yTarget int) {
	for y := yOrigin; y <= yTarget; y++ {
		for x := xOrigin; x <= xTarget; x++ {
			switch config {
			case TURN_ON:
				grid[y][x] = true
			case TURN_OFF:
				grid[y][x] = false
			case TOGGLE:
				grid[y][x] = !grid[y][x]
			}
		}
	}
}
func lightConfig2(config uint8, xOrigin int, yOrigin int, xTarget int, yTarget int) {
	for y := yOrigin; y <= yTarget; y++ {
		for x := xOrigin; x <= xTarget; x++ {
			switch config {
			case TURN_ON:
				grid2[y][x]++
			case TURN_OFF:
				grid2[y][x]--
				if grid2[y][x] < 0 {
					grid2[y][x] = 0
				}
			case TOGGLE:
				grid2[y][x] += 2
			}
		}
	}
}

func countLights() int {
	var total int
	for _, arr := range grid {
		for _, light := range arr {
			if light {
				total++
			}
		}
	}
	return total
}

func countLights2() int {
	var total int
	for _, arr := range grid2 {
		for _, light := range arr {
			if light > 0 {
				total += int(light)
			}
		}
	}
	return total
}

func part1(input string) int {
	var lines []string = line.Split(input, -1)
	for _, command := range lines {
		var commands []string = strings.Fields(command)
		if commands[0] == "turn" {
			var coordsOrigin []string = commas.Split(commands[2], -1)
			xOrigin, _ := strconv.Atoi(coordsOrigin[0])
			yOrigin, _ := strconv.Atoi(coordsOrigin[1])
			var coordsTarget []string = commas.Split(commands[4], -1)
			xTarget, _ := strconv.Atoi(coordsTarget[0])
			yTarget, _ := strconv.Atoi(coordsTarget[1])
			if commands[1] == "on" {
				lightConfig(TURN_ON, xOrigin, yOrigin, xTarget, yTarget)
			} else if commands[1] == "off" {
				lightConfig(TURN_OFF, xOrigin, yOrigin, xTarget, yTarget)
			}
		} else if commands[0] == "toggle" {
			var coordsOrigin []string = commas.Split(commands[1], -1)
			xOrigin, _ := strconv.Atoi(coordsOrigin[0])
			yOrigin, _ := strconv.Atoi(coordsOrigin[1])
			var coordsTarget []string = commas.Split(commands[3], -1)
			xTarget, _ := strconv.Atoi(coordsTarget[0])
			yTarget, _ := strconv.Atoi(coordsTarget[1])
			lightConfig(TOGGLE, xOrigin, yOrigin, xTarget, yTarget)
		}
	}
	return countLights()
}

func part2(input string) int {
	var lines []string = line.Split(input, -1)
	for _, command := range lines {
		var commands []string = strings.Fields(command)
		if commands[0] == "turn" {
			var coordsOrigin []string = commas.Split(commands[2], -1)
			xOrigin, _ := strconv.Atoi(coordsOrigin[0])
			yOrigin, _ := strconv.Atoi(coordsOrigin[1])
			var coordsTarget []string = commas.Split(commands[4], -1)
			xTarget, _ := strconv.Atoi(coordsTarget[0])
			yTarget, _ := strconv.Atoi(coordsTarget[1])
			if commands[1] == "on" {
				lightConfig2(TURN_ON, xOrigin, yOrigin, xTarget, yTarget)
			} else if commands[1] == "off" {
				lightConfig2(TURN_OFF, xOrigin, yOrigin, xTarget, yTarget)
			}
		} else if commands[0] == "toggle" {
			var coordsOrigin []string = commas.Split(commands[1], -1)
			xOrigin, _ := strconv.Atoi(coordsOrigin[0])
			yOrigin, _ := strconv.Atoi(coordsOrigin[1])
			var coordsTarget []string = commas.Split(commands[3], -1)
			xTarget, _ := strconv.Atoi(coordsTarget[0])
			yTarget, _ := strconv.Atoi(coordsTarget[1])
			lightConfig2(TOGGLE, xOrigin, yOrigin, xTarget, yTarget)
		}
	}
	return countLights2()
}

func main() {
	INPUT, err := os.ReadFile("day06.input")
	if err != nil {
		fmt.Print(err)
	}
	fmt.Println(part1(string(INPUT)))
	fmt.Println(part2(string(INPUT)))
}
