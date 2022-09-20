package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

var line *regexp.Regexp = regexp.MustCompile("\n+")
var a rune = rune('a')
var e rune = rune('e')
var i rune = rune('i')
var o rune = rune('o')
var u rune = rune('u')

func isNice(word string) bool {
	var notContains bool = !strings.Contains(word, "ab") &&
		!strings.Contains(word, "cd") &&
		!strings.Contains(word, "pq") &&
		!strings.Contains(word, "xy")
	if notContains {
		var vowels uint8
		var repeats bool
		var len = len(word)
		for idx, char := range word {
			if char == a || char == e || char == i || char == o || char == u {
				vowels++
			}
			if !repeats {
				if idx < len-1 {
					if byte(char) == word[idx+1] {
						repeats = true
					}
				}
			}
		}
		if vowels > 2 && repeats {
			return true
		}
	}
	return false
}

func isNice2(word string) bool {
	var len = len(word)
	var repeats bool
	var pair bool
	for idx, char := range word {
		if !repeats {
			if idx < len-2 {
				if byte(char) == word[idx+2] {
					repeats = true
				}
			}
		}
		if !pair {
			if idx < len-2 {
				var firstPair string = word[idx : idx+2]
				for j := idx + 2; j < len-1; j++ {
					if firstPair == word[j:j+2] {
						pair = true
					}
				}
			}
		}
		if repeats && pair {
			return true
		}
	}
	return false
}

func part2(input string) int {
	var total int
	var split []string = line.Split(input, -1)
	for _, word := range split {
		if isNice2(word) {
			total++
		}
	}
	return total
}
func part1(input string) int {
	var total int
	var split []string = line.Split(input, -1)
	for _, word := range split {
		if isNice(word) {
			total++
		}
	}
	return total
}

func main() {
	INPUT, err := os.ReadFile("day05.input")
	if err != nil {
		fmt.Print(err)
	}
	fmt.Println(part1(string(INPUT)))
	fmt.Println(part2(string(INPUT)))
}
