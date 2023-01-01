# frozen_string_literal: true

require 'pry-byebug'

# AI logic
class AI
  def self.ai_key(pegs, sym)
    key = []
    pegs.times do
      key << sym.sample
    end
    key
  end

  def self.ai_turn; end

  def code_separator()
  end

  def array_code_combiner(value, pegs)

  end

  def array_code_assembler(value)
    output_array = []
    num = value.to_s.split('').map(&:to_i)
    num.each_with_index do |el, idx|
      array_positional_builder(el, idx).each do |ell|
        output_array << ell
      end
    end
    output_array
  end

  def array_positional_builder(value, idx)
    # takes value and output a set of arrays with that value at a specified position
    i = 0
    positional_array = []
    while i < 6**3 # need total pegs guessed less one
      num = format('%03d', i.to_s(6)) # formatted with leading zeros
      positional_array << num.split('').insert(idx, value).map(&:to_i)
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

end
