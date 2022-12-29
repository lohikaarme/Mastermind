# frozen_string_literal: true

require 'pry-byebug'

# AI logic
class AI
  def array_positional_builder(value, idx, pegs)
    # takes value and output a set of arrays with that value at a specified position
    i = 0
    positional_array = []
    while i < pegs
      num = format('%03d', i.to_s(6))
      out_array = num.split('').insert(idx, value).map(&:to_i)
      positional_array << out_array
      i += 1
    end
    positional_array
  end

  # a = array_positional_builder(5, 1, 4)
  # p a

  # # binding.pry

  # b = array_positional_builder(1, 3, 6**3)
  # p b

  # c = a & b
  # p c

  def self.ai_key(pegs, sym)
    key = []
    pegs.times do
      key << sym.sample
    end
    key
  end

  def ai_turn; end
end
