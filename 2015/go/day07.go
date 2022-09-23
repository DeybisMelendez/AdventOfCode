package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

var line *regexp.Regexp = regexp.MustCompile("\n+")
var wires map[string]conection
var results map[string]uint16

type conection struct {
	a  string
	b  string
	op string
}

func contains(s map[string]uint16, e string) bool {
	for a := range s {
		if a == e {
			return true
		}
	}
	return false
}
func calc(wire string) uint16 {
	var val uint16
	i, err := strconv.Atoi(wire)
	if err == nil {
		val = uint16(i)
		return val
	}
	if contains(results, wire) {
		return results[wire]
	}
	switch wires[wire].op {
	case "EQUAL":
		val = calc(wires[wire].a)
	case "AND":
		val = calc(wires[wire].a) & calc(wires[wire].b)
	case "OR":
		val = calc(wires[wire].a) | calc(wires[wire].b)
	case "LSHIFT":
		val = calc(wires[wire].a) << calc(wires[wire].b)
	case "RSHIFT":
		val = calc(wires[wire].a) >> calc(wires[wire].b)
	case "NOT":
		val = ^calc(wires[wire].a)
	default:
		panic(wires[wire])
	}
	results[wire] = val
	return val
}

func initWires(input string) map[string]conection {
	results = make(map[string]uint16)
	var wires = make(map[string]conection)
	var lines []string = line.Split(input, -1)
	for _, command := range lines {
		var commands []string = strings.Fields(command)
		if commands[0] == "NOT" {
			wires[commands[3]] = conection{a: commands[1], op: commands[0]}
		} else if commands[1] == "->" {
			wires[commands[2]] = conection{a: commands[0], op: "EQUAL"}
		} else {
			wires[commands[4]] = conection{a: commands[0], b: commands[2], op: commands[1]}
		}
	}
	return wires
}

func part1(input string) uint16 {
	wires = initWires(string(input))
	return calc("a")
}
func part2(input string) uint16 {
	var b uint16 = results["a"]
	results = make(map[string]uint16)
	results["b"] = b
	return calc("a")
}

func main() {
	INPUT, err := os.ReadFile("day07.input")
	if err != nil {
		panic(err)
	}
	fmt.Println(part1(string(INPUT)))
	fmt.Println(part2(string(INPUT)))
}
