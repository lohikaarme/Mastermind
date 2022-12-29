# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'ai'

# Game logic
class Game
  attr_reader :game, :turn_num

  def initialize
    @game = true
    @board = Board.new
    @key = []
    @play_type = ''
    @code_breaker = ''
    @code_maker = ''
    @code_pegs = %w[RD BU YW GN WH BK]
    @pegs = 4 # assuming 4 slots for guesses
    @turn = []
    @turn_num = 0
    play_type_setup
  end

  def play
    @board.print_board
    # computer turn(maybe in setup?)
    @turn = Player.player_turn(@pegs, @code_pegs)
    @code_reference = code_update(@key, @turn)
    @board.update_board(@turn, @turn_num)
    @board.update_reference(@code_reference, @turn_num)
    @board.print_board
    win_check(@turn, @key)
  end

  def play_type_setup
    loop do
      puts 'Please chose game type:'
      puts '1: Code Breaker = Human, Code Maker = AI'
      puts '2: Code Breaker = AI, Code Maker = Human'
      @play_type = gets.to_i
      redo unless [1, 2].include?(@play_type)
      game_setup
      return
    end
  end

  def game_setup
    case @play_type
    when 1
      @code_breaker = 'Human'
      @code_maker = 'AI'
      @key = AI.ai_key(@pegs, @code_pegs)
    when 2
      @code_breaker = 'AI'
      @code_maker = 'Human'
      @key = Player.player_key(@pegs, @code_pegs)
    else
      game.game = false
    end
  end

  # rubocop:disable Metrics/MethodLength

  def code_update(key, turn)
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
    reference_convert(black, white)
  end

  # rubocop:enable Metrics/MethodLength

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
    @turn_num += 1
    if turn == key
      @game = false
      print "#{@code_breaker} wins!"
    elsif @turn_num >= 12
      @game = false
      print "#{@code_maker} wins!"
    end
  end
end
