# frozen_string_literal: true

# Human player class
class Player
  def self.player_turn(pegs, sym)
    turn = []
    puts "Select #{pegs} colors from: #{sym}"
    pegs.times do
      puts "Turn: #{turn}"
      peg = gets.chomp
      redo unless sym.include?(peg)
      turn << peg
    end
    puts "Turn: #{turn}"
    turn
  end

  def self.player_key(pegs, sym)
    key = []
    puts "Please select #{pegs} pegs from #{sym}"
    pegs.times do
      puts "Key: #{key}"
      peg = gets.chomp
      redo unless sym.include?(peg)
      key << peg
    end
    puts "Key: #{@ey}"
    key
  end
end
