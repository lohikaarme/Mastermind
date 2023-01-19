# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'ai'
require_relative 'render'

# Game logic
class Game_Logic
  attr_reader :game, :turn_num, :key

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
    # @turn = Player.player_turn(@pegs, @code_pegs)
    @turn = turn_selector(@play_type)
    @code_reference = code_check(@key, @turn)
    @board.update_board(@turn, @turn_num)
    @board.update_reference(@code_reference, @turn_num)
    @board.print_board
    win_check(@turn, @key)
  end

  def turn_selector(type)
    case type
    when 1
      Player.player_turn(@pegs, @code_pegs)
    when 2
      AI.ai_turn(@key, @code_pegs)
    end
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

  def code_check(key, turn)
    pegs = 0
    positions = 0
    temp_key = key.dup
    flag = Array.new(key.count, true)
    turn.each_with_index do |peg, idx|
      next unless peg == key[idx]

      positions += 1
      flag[idx] = false
      temp_key.delete_at(temp_key.find_index(peg))
    end
    turn.each_with_index do |peg, idx|
      temp_key.each_with_index do |pegp, _idxp|
        next unless peg == pegp && flag[idx] == true

        pegs += 1
        flag[idx] = false
        temp_key.delete_at(temp_key.find_index(peg))
      end
    end
    [positions, pegs]
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
