# frozen_string_literal: true

require_relative 'board'

# Game logic
class Game
  def initialize
    @board = Board.new
    @key = []
    @code_breaker = 'Human'
    @code_maker = 'AI'
    @code_pegs = %w[RD BU YW GN WH BK]
    @pegs = 4 # assuming 4 slots for guesses
  end

  def play
    # setup
    ai_key(@pegs)
    # render board
    @board.print_board
    # computer turn(maybe in setup?)
    # player turns
    player_turn(@pegs)
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

  def ai_key(pegs)
    @key = []
    pegs.times do
      @key << @code_pegs.sample
    end
  end

  def player_turn(pegs)
    @turn = []
    puts "Select #{pegs} colors from: #{@code_pegs}"
    pegs.times do
      @turn << gets.chomp # .match(@code_pegs), need to sanitize the input
    end
    p @turn

  end

end
