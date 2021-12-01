package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	numbers := loadNumbers()
	increaseCount := 0

	for idx, n := range numbers {
		if idx == 0 {
			continue
		}

		if numbers[idx-1] < n {
			increaseCount += 1
		}
	}
	fmt.Println("Larger increment count: ", increaseCount)
}

func loadNumbers() []int {
	data, _ := os.ReadFile("input.txt")
	var numbers []int
	for _, n := range strings.Split(string(data), "\n") {
		i, err := strconv.Atoi(n)
		if err == nil {
			numbers = append(numbers, i)
		}
	}
	return numbers
}
