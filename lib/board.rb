# frozen_string_literal: true

# Game board
class Board
  attr_reader :board, :reference, :key

  def initialize
    @board = Array.new(12, Array.new(4, [nil]))
    @reference = Array.new(12, Array.new(4, [nil]))
    @key = Array.new(4, [nil])
  end

  def print_board(_board)
    puts <<-HEREDOC
 _|      _|                        _|                                          _|                  _|
 _|_|  _|_|    _|_|_|    _|_|_|  _|_|_|_|    _|_|    _|  _|_|  _|_|_|  _|_|        _|_|_|      _|_|_|
 _|  _|  _|  _|    _|  _|_|        _|      _|_|_|_|  _|_|      _|    _|    _|  _|  _|    _|  _|    _|
 _|      _|  _|    _|      _|_|    _|      _|        _|        _|    _|    _|  _|  _|    _|  _|    _|
 _|      _|    _|_|_|  _|_|_|        _|_|    _|_|_|  _|        _|    _|    _|  _|  _|    _|    _|_|_|
 ____________________________________________________________________________________________________
 ____________________________________________________________________________________________________

       Guess                               Reference
  1 |  #{@board[0]}        #{@reference[0]}
  2 |  #{@board[1]}        #{@reference[1]}
  3 |  #{@board[2]}        #{@reference[2]}
  4 |  #{@board[3]}        #{@reference[3]}
  5 |  #{@board[4]}        #{@reference[4]}
  6 |  #{@board[5]}        #{@reference[5]}
  7 |  #{@board[6]}        #{@reference[6]}
  8 |  #{@board[7]}        #{@reference[7]}
  9 |  #{@board[8]}        #{@reference[8]}
 10 |  #{@board[9]}        #{@reference[9]}
 11 |  #{@board[10]}        #{@reference[10]}
 12 |  #{@board[11]}        #{@reference[11]}
    HEREDOC
  end
end

# test = Board.new
# test.print_board(test)
