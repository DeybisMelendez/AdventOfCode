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
	return strings.Split(inputStr, "\r\n\r\n") // windows \r\n\r\n linux \n\n
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
		keys := []string{}
		for _, e := range passport {
			key, value := e[:3], e[4:]
			if !contains(keys, key) {
				keys = append(keys, key)
			}
			switch key {
			case "byr":
				num, _ := strconv.Atoi(value)
				if !(num >= 1920 && num <= 2002) && len(value) == 4 {
					isValid = false
					break
				}
			case "iyr":
				num, _ := strconv.Atoi(value)
				if !(num >= 2010 && num <= 2020) && len(value) == 4 {
					isValid = false
					break
				}
			case "eyr":
				num, _ := strconv.Atoi(value)
				if !(num >= 2020 && num <= 2030) && len(value) == 4 {
					isValid = false
					break
				}
			case "hgt":
				unit := e[len(e)-2:]
				if unit == "cm" || unit == "in" {
					num, err := strconv.Atoi(e[4 : len(e)-2])
					if err != nil {
						isValid = false
						break
					} else {
						if unit == "cm" && !(num >= 150 && num <= 193) {
							isValid = false
							break
						} else if unit == "in" && !(num >= 59 && num <= 76) {
							isValid = false
							break
						}
					}
				} else {
					isValid = false
					break
				}
			case "hcl":
				regex := regexp.MustCompile("#[0-9,a-f]+")
				hex := regex.FindString(value)
				if hex == "" || len(hex) != 7 {
					isValid = false
					break
				}
			case "ecl":
				switch value {
				case "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
				default:
					isValid = false
					break
				}
			case "pid":
				_, err := strconv.Atoi(value)
				if len(value) != 9 && err != nil {
					isValid = false
					break
				}
			case "cid":
				hasCID = true
			}

		}
		if isValid {
			if hasCID {
				if len(keys) == 8 {
					valids++
				}
			} else if len(keys) == 7 {
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
