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
  attr_reader :bingo_numbers, :score

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

  def calculate_score(winning_num)
    @score = unmarked_sum * winning_num
  end
end

class Bingo
  def initialize
    @boards = []
  end

  def play
    read_input
    won_boards = []

    @drawn_numbers.each do |num|
      @boards.each do |b|
        b.mark(num)

        @boards.each do |board|
          next unless board.won?
          next if won_boards.include?(board)

          board.calculate_score(num)
          won_boards << board
        end
      end
    end

    puts "The last board to win score is #{won_boards.last.score}"
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
