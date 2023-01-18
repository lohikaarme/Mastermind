# frozen_string_literal: true

require 'pry'

# AI logic
class AI
  @pegs = [1, 2, 3, 4, 5, 6]
  @combo = @pegs.repeated_permutation(4).to_a
  @guess = [1, 1, 2, 2]
  @last_guess = []
  @key = @combo.sample

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

  def self.array_to_hash(arg)
    Hash[arg.map { |el| [el, 0] }]
  end

  def self.idx_to_array(array)
    new_array = []
    array.each_with_index do |el, idx|
      new_array << (el + (idx * 0.1).round(1))
    end
    new_array
  end

  def self.list_match(guess, list, sign, matches)
    hash_map = array_to_hash(list)
    guess_idx = idx_to_array(guess)
    list.each_with_index do |el, _idx|
      el_idx = idx_to_array(el)
      hash_map[el] += sign if (el_idx & guess_idx).count >= matches[0] && (el & guess).count >= matches[1]
    end
    hash_map[@guess] = 0
    if sign == -1
      hash_map.select { |_k, v| v >= 0 }
    else
      hash_map.select { |_k, v| v.positive? }
    end
  end

  def self.matching(key, guess, list)
    new_list = {}
    check = checker(key, guess)
    case check
    when [0, 0]
      new_list = list_match(guess, list, -1, [0, 1])
    when [4, 0], [4, 1], [4, 2], [4, 3]
      p 'AI wins'
      p "Key:#{@key}, Guess#{@guess}"
    else
      new_list = list_match(guess, list, 1, check)
    end
    p new_list
    p new_list.count
    p check
    @combo = new_list.keys
  end

  def self.combination_refresher(list)
    @combo = list.keys
  end

  def self.next_guess(list)
    hash_map = array_to_hash(list)
    @last_guess = @guess
    list.each_with_index do |el, _idx|
      list.each_with_index do |elp, _idxp|
        elp.each_with_index do |elpp, idxpp|
          hash_map[el] += 1 if el[idxpp] == elpp
        end
      end
    end
    @guess = hash_map.max_by { |_k, v| v }[0]
    @guess = list.sample if @guess == @last_guess
  end

  def self.ai_turn
    matching(@key, @guess, @combo)
    next_guess(@combo)
  end
end
