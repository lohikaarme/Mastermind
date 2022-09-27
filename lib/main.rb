# frozen_string_literal: true

# mastermind exercise to replicate the classic game

require 'pry-byebug'
require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'render'

# binding.pry

def game_start
  game = Game.new
  game.play
  # logic to play_again
end

def play_again
  # get prompt
end
