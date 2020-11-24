package main

import (
	"fmt"
	"io/ioutil"
	"math"
	"regexp"
	"strconv"
)

func getParams(params string) [][]string {
	regex := regexp.MustCompile("(\\d*)x(\\d*)x(\\d*)")
	return regex.FindAllStringSubmatch(params, -1)
}

func answer1(input string) int {
	params := getParams(input)
	total := 0.0
	for _, gift := range params {
		l, _ := strconv.ParseFloat(gift[1], 64)
		w, _ := strconv.ParseFloat(gift[2], 64)
		h, _ := strconv.ParseFloat(gift[3], 64)
		total += 2*l*w + 2*w*h + 2*h*l + math.Min(l*w, math.Min(w*h, h*l))
	}
	return int(total)
}

func answer2(input string) int {
	params := getParams(input)
	total := 0.0
	for _, gift := range params {
		l, _ := strconv.ParseFloat(gift[1], 64)
		w, _ := strconv.ParseFloat(gift[2], 64)
		h, _ := strconv.ParseFloat(gift[3], 64)
		sum := l + w + h
		max := math.Max(l, math.Max(w, h))
		total += 2*(sum-max) + l*w*h
	}
	return int(total)
}

func main() {
	input, _ := ioutil.ReadFile("02input.txt")
	text := string(input)
	fmt.Println(answer1(text))
	fmt.Println(answer2(text))
}
