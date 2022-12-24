# frozen_string_literal: true

require_relative 'board'

# Game logic
class Game
  attr_reader :game, :turn_num

  def initialize
    @game = true
    @board = Board.new
    @key = []
    @code_breaker = 'Human'
    @code_maker = 'AI'
    @code_pegs = %w[RD BU YW GN WH BK]
    @pegs = 4 # assuming 4 slots for guesses
    ai_key(@pegs)
    @turn_num = 0
  end

  def play
    # setup
    # render board
    @board.print_board
    # computer turn(maybe in setup?)
    # player turns
    player_turn(@pegs)
    code_update(@key, @turn)
    @board.update_board(@turn, @turn_num)
    @board.update_reference(@code_reference, @turn_num)
    @board.print_board
    win_check(@turn, @key)
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

  def code_update(key, turn)
    @code_reference = []
    black = []
    white = []
    key.each_with_index do |key_el, key_i|
      turn.each_with_index do |turn_el, turn_i|
        if turn_el == key_el && turn_i == key_i
          black << key_i
        elsif turn_el == key_el
          white << key_i
        end
      end
    end
    @code_reference = reference_convert(black, white)
  end

  def reference_convert(black, white)
    coded = []
    white -= black # removes duplicate values from white
    black.uniq.count.times do
      coded << 'BK'
    end
    white.uniq.count.times do
      coded << 'WH'
    end
    coded
  end

  def win_check(turn, key)
    @game = false if turn == key
    @turn_num += 1
  end
end
