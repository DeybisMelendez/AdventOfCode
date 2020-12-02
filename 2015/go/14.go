package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
)

type reindeer struct {
	name      string
	speed     int
	timespeed int
	resttime  int
}

func getParams(params string) []reindeer {
	regex := regexp.MustCompile("(\\w+).+?(\\d+).+?(\\d+).+?(\\d+).+?")
	var result []reindeer
	for _, v := range regex.FindAllStringSubmatch(params, -1) {
		r := reindeer{v[1], v[2], v[3], v[4]}
		result = append(result, r)
	}
	return result
}
func answer1(input string) int {
	fmt.Println(getParams(input))
	return 0
}

func main() {
	data, _ := ioutil.ReadFile("14input.txt")
	text := string(data)
	answer1(text)
}
