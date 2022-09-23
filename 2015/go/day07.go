package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

// usar maps
// https://gobyexample.com/maps
var line *regexp.Regexp = regexp.MustCompile("\n+")

func initWires(input string) map[string]func() uint16 {
	var wires = make(map[string]func() uint16)
	var lines []string = line.Split(input, -1)
	for _, command := range lines {
		var commands []string = strings.Fields(command)
		if commands[0] == "NOT" {
			wires[commands[3]] = func() uint16 { return ^wires[commands[1]]() }
		} else {
			switch commands[2] {
			case "AND":
				wires[commands[4]] = func() uint16 { return wires[commands[0]]() & wires[commands[2]]() }
			case "OR":
				wires[commands[4]] = func() uint16 { return wires[commands[0]]() | wires[commands[2]]() }
			case "LSHIFT":
				wires[commands[4]] = func() uint16 { return wires[commands[0]]() << wires[commands[2]]() }
			case "RSHIFT":
				wires[commands[4]] = func() uint16 { return wires[commands[0]]() >> wires[commands[2]]() }
			default:
				wires[commands[2]] = wires[commands[0]]
			}
		}
	}
	return wires
}

func part1(input string) int {
	return 0
}

func main() {
	INPUT, err := os.ReadFile("day07.input")
	if err != nil {
		fmt.Print(err)
	}
	var wires = initWires(string(INPUT))
	fmt.Println(wires["a"]())
	//fmt.Println(part1(string(INPUT)))
	//fmt.Println(part2(string(INPUT)))
}
