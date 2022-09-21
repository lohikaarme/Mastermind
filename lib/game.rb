# frozen_string_literal: true

# Game logic
class Game
  def initialize
    @board = Board.new
    @code_breaker = 'Human'
    @code_maker = 'AI'
  end

  def play
    # setup
    # render board
    # computer turn(maybe in setup?)
    # player turns
    # end_game
  end

  def turn
    # player enters guess of 4 pegs
    # peg layout is checked against key
    # reference based on number of correct colours and/or locations added to reference
    # board with updated reference printed
    # game checks for win/lose condition condition
    # next turn
  end
end
