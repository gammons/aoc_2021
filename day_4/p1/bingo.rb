require 'byebug'

class BingoNumber
  attr_reader :number, :is_marked

  def initialize(number)
    @number = number
    @is_marked = false
  end

  def mark!
    @is_marked = true
  end
end

class Board
  attr_reader :bingo_numbers

  def initialize
    @rows = []
  end

  def add_row(nums)
    @rows << nums.map { |n| BingoNumber.new(n.to_i) }
  end

  def mark(number)
    @rows.each do |row|
      row.each do |bn|
        bn.mark! if bn.number == number
      end
    end
  end

  def won?
    @rows.any? { |r| r.all?(&:is_marked) } ||
      @rows.transpose.any? { |r| r.all?(&:is_marked) }
  end

  def unmarked_sum
    @rows.inject(0) do |sum, row|
      sum + row.inject(0) do |s, bn|
        bn.is_marked ? s : s + bn.number
      end
    end
  end
end

class Bingo
  def initialize
    @boards = []
  end

  def play
    read_input
    @drawn_numbers.each do |num|
      @boards.each do |b|
        b.mark(num)

        @boards.each do |board|
          next unless board.won?

          puts "Someone won with number #{num}"
          puts "The unmarked sum is #{board.unmarked_sum}"
          puts "The score is #{board.unmarked_sum * num}"
          exit
        end
      end
    end
  end

  private

  def read_input
    lines = File.read('input.txt').split("\n")
    @drawn_numbers = lines[0].split(',').map(&:to_i)

    board = Board.new
    lines[2..lines.length - 1].each do |line|
      if line == ''
        @boards << board
        board = Board.new
      else
        board.add_row(line.split(' '))
      end
    end
    @boards << board
  end
end

Bingo.new.play
