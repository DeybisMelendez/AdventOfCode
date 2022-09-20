package main

import (
	"fmt"
	"math"
	"os"
	"regexp"
	"strconv"
)

var line *regexp.Regexp = regexp.MustCompile("\n+")
var dims *regexp.Regexp = regexp.MustCompile("x+")

func part1(input string) int {
	var total int = 0
	var split []string = line.Split(input, -1)
	for _, item := range split {
		var dim []string = dims.Split(item, -1)
		l, _ := strconv.Atoi(dim[0])
		w, _ := strconv.Atoi(dim[1])
		h, _ := strconv.Atoi(dim[2])
		a1 := l * w
		a2 := w * h
		a3 := h * l
		extra := math.Min(math.Min(float64(a1), float64(a2)), float64(a3))
		total += 2*a1 + 2*a2 + 2*a3 + int(extra)
	}
	return total
}

func part2(input string) int {
	var total int = 0
	var split []string = line.Split(input, -1)
	for _, item := range split {
		var dim []string = dims.Split(item, -1)
		l, _ := strconv.Atoi(dim[0])
		w, _ := strconv.Atoi(dim[1])
		h, _ := strconv.Atoi(dim[2])
		extra := (l + w + h - int(math.Max(math.Max(float64(l), float64(w)), float64(h)))) * 2
		ribbon := l*w*h + extra
		total += ribbon
	}
	return total
}

func main() {
	INPUT, err := os.ReadFile("day02.input")
	if err != nil {
		fmt.Print(err)
	}
	fmt.Println(part1(string(INPUT)))
	fmt.Println(part2(string(INPUT)))
}
