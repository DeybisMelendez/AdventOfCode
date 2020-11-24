package main

import (
	"fmt"
	"regexp"
)

func getParams(input string) [][]string {
	regex := regexp.MustCompile("\\d*x\\d*x\\d*")
	return regex.FindAllStringSubmatch(input, -1)
}

func main() {
	fmt.Println(getParams(ioutil.readFile("01input.txt")))
}
