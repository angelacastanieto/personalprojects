// Write a program which prompts the user to enter integers and stores the integers in a sorted slice.
// The program should be written as a loop. Before entering the loop, the program should create an empty integer
// slice of size (length) 3. During each pass through the loop, the program prompts the user to enter an integer to
// be added to the slice. The program adds the integer to the slice, sorts the slice, and prints the contents of
// the slice in sorted order. The slice must grow in size to accommodate any number of integers which the user
// decides to enter. The program should only quit (exiting the loop) when the user enters the character ‘X’ instead of an integer.

package main

import (
	"fmt"
	"sort"
	"strconv"
)

func main() {
	lenNums := 3

	nums := make([]int, lenNums)
	var i int

	for {
		fmt.Println("Enter an integer: ")
		var char string
		fmt.Scanln(&char)

		if char == "X" {
			break
		} else {
			num, _ := strconv.Atoi(char)
			fmt.Printf("char %s\n", char)
			if i < lenNums {
				fmt.Printf("i %d\n", i)
				fmt.Printf("nums[i] %v", nums[i])
				nums[i] = num
				i++
			} else {
				nums = append(nums, num)
			}

			sort.Ints(nums)

			fmt.Println(nums)
		}
	}
}
