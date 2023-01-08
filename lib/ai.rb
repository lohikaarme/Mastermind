# frozen_string_literal: true

require 'pry'

# AI logic
class AI
  @pegs = [1, 2, 3, 4, 5, 6]
  @combo = @pegs.repeated_permutation(4).to_a
  @guess = [1, 1, 2, 2]
  @last_guess = []
  @key = @combo.sample
  @hash_map = {}

  def self.ai_key(pegs, sym)
    key = []
    pegs.times do
      key << sym.sample
    end
    key
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

  def self.list_match(guess_idx, list, sign, matches)
    list.each_with_index do |el, _idx|
      el_idx = idx_to_array(el)
      @hash_map[el] += sign if (el_idx & guess_idx).count >= matches
    end
    @hash_map[@guess] = 0
    if sign == -1
      @hash_map.select { |_k, v| v >= 0 }
    else
      @hash_map.select { |_k, v| v.positive? }
    end
  end

  def self.matching(key, guess, list)
    @hash_map = hash_to_match(list)
    new_list = {}
    guess_idx = idx_to_array(guess)
    case checker(key, guess)

    when [0]
      new_list = list_match(guess_idx, list, -1, 1)
    when [1]
      new_list = list_match(guess_idx, list, 1, 1)
    when [2]
      new_list = list_match(guess_idx, list, 1, 2)
    when [3]
      new_list = list_match(guess_idx, list, 1, 3)
    when [4]
      p 'AI wins'
      p "key:#{@key}, Guess#{@guess}"
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
    @last_guess = @guess
    list.each_with_index do |el, _idx|
      list.each_with_index do |elp, _idxp|
        elp.each_with_index do |elpp, idxpp|
          @hash_map[el] += 1 if el[idxpp] == elpp
        end
      end
    end
    @guess = @hash_map.min_by { |_k, v| v }[0]
  end

  def self.last_guess_check(last_guess, guess, list)
    @guess = list.sample if guess == last_guess
  end


  def self.ai_turn
    matching(@key, @guess, @combo)
    next_guess(@combo)
    last_guess_check(@last_guess, @guess, @combo)
  end

  p 5 + 5
  binding.pry
end
