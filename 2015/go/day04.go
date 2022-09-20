package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
)

const INPUT string = "yzbqklnj"

func part1(input string) int {
	var value int = 10000
	for {
		var test string = input + fmt.Sprint(value)
		hash := md5.Sum([]byte(test))
		hex := hex.EncodeToString(hash[:])
		if hex[:5] == "00000" {
			return value
		}
		value++
	}
}

func part2(input string) int {
	var value int = 10000
	for {
		var test string = input + fmt.Sprint(value)
		hash := md5.Sum([]byte(test))
		hex := hex.EncodeToString(hash[:])
		if hex[:6] == "000000" {
			return value
		}
		value++
	}
}

func main() {
	fmt.Println(part1(INPUT))
	fmt.Println(part2(INPUT))
}
