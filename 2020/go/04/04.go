package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
	"strings"
)

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}
func getInput(inputStr string) []string {
	return strings.Split(inputStr, "\n\n") // windows \r\n\r\n linux \n\n
}

func getPassportParams(str string) []string {
	regex := regexp.MustCompile("([\\w,\\d,:,#]+)")
	return regex.FindAllString(str, -1)
}
func answer1(inputStr string) int {
	input := getInput(inputStr)
	valids := 0
	for _, v := range input {
		passport := getPassportParams(v)
		hasCID := false
		for _, e := range passport {
			if e[:3] == "cid" {
				hasCID = true
				break
			}
		}
		if hasCID {
			if len(passport) == 8 {
				valids++
			}
		} else if len(passport) == 7 {
			valids++
		}
	}
	return valids
}

func answer2(inputStr string) int {
	input := getInput(inputStr)
	valids := 0
	for _, v := range input {
		passport := getPassportParams(v)
		hasCID := false
		isValid := true
		for _, e := range passport {
			key, value := e[:3], e[4:]
			switch key {
			case "byr":
				regex := regexp.MustCompile("\\d{4}")
				digits := regex.FindString(value)
				num, err := strconv.Atoi(digits)
				if !(err == nil && num >= 1920 && num <= 2002) {
					isValid = false
					break
				}
			case "iyr":
				regex := regexp.MustCompile("\\d{4}")
				digits := regex.FindString(value)
				num, err := strconv.Atoi(digits)
				if !(err == nil && num >= 2010 && num <= 2020) {
					isValid = false
					break
				}
			case "eyr":
				regex := regexp.MustCompile("\\d{4}")
				digits := regex.FindString(value)
				num, err := strconv.Atoi(digits)
				if !(err == nil && num >= 2020 && num <= 2030) {
					isValid = false
					break
				}
			case "hgt":
				regex := regexp.MustCompile("(\\d+)(cm|in)")
				hair := regex.FindStringSubmatch(value)
				if len(hair) != 0 {
					cmin := hair[2]
					num, _ := strconv.Atoi(hair[1])
					if !((cmin == "cm" && num >= 150 && num <= 193) || (cmin == "in" && num >= 59 && num <= 76)) {
						isValid = false
						break
					}
				} else {
					isValid = false
					break
				}
			case "hcl":
				regex := regexp.MustCompile("^#[0-9a-f]{6}$")
				hex := regex.FindString(value)
				if hex == "" {
					isValid = false
					break
				}
			case "ecl":
				regex := regexp.MustCompile("amb|blu|brn|gry|grn|hzl|oth")
				ecl := regex.FindString(value)
				if ecl == "" {
					isValid = false
					break
				}
			case "pid":
				regex := regexp.MustCompile("^\\d{9}$")
				digits := regex.FindString(value)
				if digits == "" {
					isValid = false
					break
				}
			case "cid":
				hasCID = true
			}

		}
		if isValid {
			if hasCID {
				if len(passport) == 8 {
					valids++
				}
			} else if len(passport) == 7 {
				valids++
			}
		}
	}
	return valids
}

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Println(answer1(string(input)))
	fmt.Println(answer2(string(input)))
}
