package main

import (
	"fmt"
	"strings"
)

const (
	NotFound = "Not Found!"
	Found    = "Found!"
)

func main() {
	fmt.Println("Enter a string: ")
	var str string
	fmt.Scanln(&str)

	if len(str) < 3 {
		fmt.Print(NotFound)
		return
	}

	firstChar := strings.ToLower(string(str[0]))
	if firstChar != "i" {
		fmt.Print(NotFound)
		return
	}

	lastChar := strings.ToLower(string(str[len(str)-1]))
	if lastChar != "n" {
		fmt.Println(NotFound)
		return
	}

	for i := 0; i < len(str); i++ {
		char := strings.ToLower(string(str[i]))
		if char == "a" {
			fmt.Println(Found)
			return
		}
	}

	fmt.Println(NotFound)
}
