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
	prevSum := -1

	for idx := range numbers {
		if idx == 0 || idx == len(numbers)-1 {
			continue
		}

		sum := numbers[idx-1] + numbers[idx] + numbers[idx+1]

		if prevSum != -1 && prevSum < sum {
			increaseCount += 1
		}

		prevSum = sum

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
