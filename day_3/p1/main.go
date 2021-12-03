package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	nums := readInput()
	var total []int

	for pos := range strings.Split(nums[0], "") {
		count := 0
		for _, num := range nums {
			if strings.Split(num, "")[pos] == "1" {
				count += 1
			}
		}
		total = append(total, count)
	}

	var delta []string
	var epsilon []string
	for _, count := range total {
		if count > len(nums)/2 {
			delta = append(delta, "1")
			epsilon = append(epsilon, "0")
		} else {
			delta = append(delta, "0")
			epsilon = append(epsilon, "1")
		}
	}

	deltaInt, _ := strconv.ParseInt(strings.Join(delta, ""), 2, 64)
	epsilonInt, _ := strconv.ParseInt(strings.Join(epsilon, ""), 2, 64)

	fmt.Printf("Delta = %v, dec = %v\n", delta, deltaInt)
	fmt.Printf("Epsilon = %v, dec = %v\n", epsilon, epsilonInt)
	fmt.Println("Power = ", deltaInt*epsilonInt)
}

func readInput() []string {
	data, _ := os.ReadFile("input.txt")
	var numbers []string

	for _, data := range strings.Split(string(data), "\n") {
		if data == "" {
			continue
		}
		numbers = append(numbers, data)
	}
	return numbers
}
