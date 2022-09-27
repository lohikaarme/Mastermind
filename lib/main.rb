# frozen_string_literal: true

# mastermind exercise to replicate the classic game 

require 'pry-byebug'
require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'render.rb'

# binding.pry

def game_start
  game = Game.new
  game.play
  # logic to play_again
end

def play_again
  # get prompt
end
