package main

import "fmt"

func main() {
	fmt.Println("Enter a floating point number: ")
	var num float64
	fmt.Scanln(&num)
	fmt.Println(int64(num))
}
