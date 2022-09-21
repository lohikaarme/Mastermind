# frozen_string_literal: true

# Game board
class Board
  attr_reader :board, :reference, :key

  def initialize
    @board = Array.new(12, Array.new(4, [nil]))
    @reference = Array.new(12, Array.new(4, [nil]))
    @key = Array.new(4, [nil])
  end
end
