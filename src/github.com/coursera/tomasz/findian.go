package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	fmt.Println("Enter string:")

	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	str := scanner.Text()

	if len(str) < 3 {
		fmt.Println("Not Found!")
		return
	}

	lowerStr := strings.ToLower(str)
	strLen := len(lowerStr)
	if lowerStr[0] == 'i' && lowerStr[strLen-1] == 'n' && strings.Contains(lowerStr[1:strLen-1], "a") {
		fmt.Println("Found!")
		return
	}

	fmt.Println("Not Found!")
}
