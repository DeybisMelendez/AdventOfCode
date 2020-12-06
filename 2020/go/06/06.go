package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func getInput(inputStr string) []string {
	return strings.Split(inputStr, "\n\n") // windows \r linux \n
}

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func remove(slice []string, s int) []string {
	return append(slice[:s], slice[s+1:]...)
}

func answer1(inputStr string) int {
	input := getInput(inputStr)
	total := 0
	for _, v := range input {
		v = strings.Replace(v, "\n", "", -1)
		var letters []string
		for _, r := range v {
			char := string(r)
			if !contains(letters, char) {
				letters = append(letters, char)
			}
		}
		total += len(letters)
	}
	return total
}

func answer2(inputStr string) int {
	input := getInput(inputStr)
	total := 0
	for _, v := range input {
		split := strings.Split(v, "\n")
		letters := split[0]
		split = remove(split, 0)
		for _, v := range split {
			for _, r := range letters {
				char := string(r)
				if !strings.Contains(v, char) {
					letters = strings.Replace(letters, char, "", -1)
				}
			}
		}
		total += len(letters)
	}
	return total
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Println(answer1(string(input)))
	fmt.Println(answer2(string(input)))
}
