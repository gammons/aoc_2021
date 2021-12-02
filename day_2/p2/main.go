package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Command struct {
	Direction string
	Units     int
}

func main() {
	commands := readInput()
	depth := 0
	x := 0
	aim := 0

	for _, command := range commands {
		switch command.Direction {
		case "forward":
			x += command.Units
			depth += aim * command.Units
		case "up":
			aim -= command.Units
		case "down":
			aim += command.Units
		}
	}
	fmt.Printf("Depth = %v, X = %v, total = %v\n", depth, x, (depth * x))
}

func readInput() []*Command {
	data, _ := os.ReadFile("input.txt")
	var commands []*Command

	for _, cmdStr := range strings.Split(string(data), "\n") {
		if cmdStr == "" {
			continue
		}

		cmd := strings.Split(cmdStr, " ")
		units, _ := strconv.Atoi(cmd[1])

		command := &Command{
			Direction: cmd[0],
			Units:     units,
		}

		commands = append(commands, command)
	}
	return commands
}
