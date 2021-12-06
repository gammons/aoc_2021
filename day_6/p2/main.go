package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	fishes := loadNumbers()
	for x := 1; x <= 80; x++ {
		var arr []int
		add := 0
		for _, fish := range fishes {
			fish = fish - 1
			if fish < 0 {
				fish = 6
				add += 1
			}
			arr = append(arr, fish)
		}

		for y := 1; y <= add; y++ {
			arr = append(arr, 8)
		}
		fishes = arr

		fmt.Printf("x = %v, fishes = %v\n", x, len(fishes))
	}
}

func loadNumbers() []int {
	data, _ := os.ReadFile("input2.txt")
	var numbers []int
	for _, n := range strings.Split(string(data), ",") {
		i, err := strconv.Atoi(strings.TrimSuffix(n, "\n"))
		if err == nil {
			numbers = append(numbers, i)
		}
	}
	return numbers
}
