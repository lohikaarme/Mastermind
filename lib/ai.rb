# frozen_string_literal: true

require 'pry'

# AI logic
class AI
  def self.ai_key(pegs, sym)
    key = []
    pegs.times do
      key << sym.sample
    end
    key
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

  def self.checker(key, turn)
    pegs = 0
    positions = 0
    turn.each_with_index do |peg, idx|
      if peg == key[idx]
        positions += 1
      elsif key.include?(peg)
        pegs += 1
      end
    end
    [positions]
  end

  @pegs = [1, 2, 3, 4, 5, 6]
  @combo = @pegs.repeated_permutation(4).to_a
  @guess = [2, 2, 1, 1]
  @key = @combo.sample
  @hash_map = {}

  def self.hash_to_match(arg)
    Hash[arg.map { |el| [el, 0] }]
  end

  def self.idx_to_array(array)
    new_array = []
    array.each_with_index do |el, idx|
      new_array << (el + (idx * 0.1).round(1))
    end
    new_array
  end

  def self.matching(key, guess, list)
    @hash_map = hash_to_match(list)
    new_list = {}
    guess_idx = idx_to_array(guess)
    case checker(key, guess)

    when [0]
      list.each_with_index do |el, _idx|
        el_idx = idx_to_array(el)
        @hash_map[el] -= 1 if (el_idx & guess_idx).count >= 1
      end
      new_list = @hash_map.select { |_k, v| v >= 0 }

    when [1]
      list.each_with_index do |el, _idx|
        el_idx = idx_to_array(el)
        @hash_map[el] += 1 if (el_idx & guess_idx).count >= 1
      end
      new_list = @hash_map.select { |_k, v| v.positive? }
    when [2]
      list.each_with_index do |el, _idx|
        el_idx = idx_to_array(el)
        @hash_map[el] += 1 if (el_idx & guess_idx).count >= 2
      end
      new_list = @hash_map.select { |_k, v| v.positive? }
    when [3]
      list.each_with_index do |el, _idx|
        el_idx = idx_to_array(el)
        @hash_map[el] += 1 if (el_idx & guess_idx).count >= 3
      end
      new_list = @hash_map.select { |_k, v| v.positive? }
    when [4]
      p 'AI wins'
    end
    p new_list
    p new_list.count
    @combo = new_list.keys
  end

  def self.combination_refresher(list)
    @combo = list.keys
  end

  def self.next_guess(list)
    @hash_map = hash_to_match(list)
    list.each_with_index do |el, _idx|
      list.each_with_index do |elp, _idxp|
        elp.each_with_index do |elpp, idxpp|
          @hash_map[el] += 1 if el[idxpp] == elpp
        end
      end
    end
    @guess = @hash_map.min_by { |_k, v| v }[0]
  end

  def self.ai_turn
    matching(@key, @guess, @combo)
    next_guess(@combo)
  end

  p 5 + 5
  binding.pry
end
