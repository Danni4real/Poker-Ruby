# frozen_string_literal: true

require_relative 'Card'
require_relative 'Cards'

def remove_singles(str)
  str.gsub(/./) { |char| str.count(char) == 1 ? "" : char }
end

def remove_pairs(str)
  str.gsub(/./) { |char| str.count(char) == 2 ? "" : char }
end

def is_consecutive_letters(str)
  return false unless str =~ /^[a-z]+$/
  str.chars.each_cons(2).all? { |a, b| b.ord == a.ord + 1 }
end

def remove_duplicates(str)
  str.chars.uniq.join
end

def match_single(str)
  match = /^[a-lnpr]$/.match?(str)

  if match
    return str[0]
  end

  false
end

def match_straight(str)
  match = (str.size >= 5 and is_consecutive_letters(str))

  if match
    return str[-1]
  end

  false
end

def match_pair(str)
  match = /^([a-lnpr])\1$/.match?(str)

  if match
    return str[-1]
  end

  false
end

def match_pairs(str)
  match = (str.size >= 6 and /^(([a-lnpr])\2)+$/.match?(str) and
    is_consecutive_letters(remove_duplicates(str)))

  if match
    return str[-1]
  end

  false
end

def match_triple(str)
  match = /^([a-lnpr])\1\1$/.match?(str)

  if match
    return str[-1]
  end

  false
end

def match_triples(str)
  match = (str.size >= 6 and /^(([a-lnpr])\2\2)+$/.match?(str) and
    is_consecutive_letters(remove_duplicates(str)))

  if match
    return str[-1]
  end

  false
end

def match_bomb(str)
  match = /^([a-lnpr])\1\1\1$/.match?(str)

  if match
    return str[-1]
  end

  false
end

def match_bomb_plus_2_singles(str)
  match = (str.size == 6 and remove_duplicates(str).size == 3 and
    (match_bomb(str[0, 4]) or
      match_bomb(str[1, 4]) or
      match_bomb(str[2, 4])))

  if match
    return remove_singles(str)[-1]
  end

  false
end

def match_bomb_plus_2_pairs(str)
  match = (str.size == 8 and remove_duplicates(str).size == 3 and
    ((match_bomb(str[0, 4]) and match_pair(str[4, 2]) and match_pair(str[6, 2])) or
      (match_bomb(str[2, 4]) and match_pair(str[0, 2]) and match_pair(str[6, 2])) or
      (match_bomb(str[4, 4]) and match_pair(str[0, 2]) and match_pair(str[2, 2]))))

  if match
    return remove_pairs(str)[-1]
  end

  false
end

def match_nuke(str)
  match = (str == "pr") # "BR"
  if match
    return str[-1]
  end

  false
end

def match_3plus1(str)
  match = (str.size == 4 and remove_duplicates(str).size == 2 and
    (match_triple(str[0, 3]) or
      match_triple(str[1, 3])))

  if match
    return remove_singles(str)[-1]
  end

  false
end

def match_3plus1s(str)
  match = (match_3plus1_X2(str) or
    match_3plus1_X3(str) or
    match_3plus1_X4(str) or
    match_3plus1_X5(str))

  if match
    return remove_singles(str)[-1]
  end

  false
end

def match_3plus1_X2(str)
  str.size == 8 and (remove_duplicates(str)).size == 4 and
    (match_triples(str[0, 6]) or
      match_triples(str[1, 6]) or
      match_triples(str[2, 6]))
end

def match_3plus1_X3(str)
  str.size == 12 and (remove_duplicates(str)).size == 6 and
    (match_triples(str[0, 9]) or
      match_triples(str[1, 9]) or
      match_triples(str[2, 9]) or
      match_triples(str[3, 9]))
end

def match_3plus1_X4(str)
  str.size == 16 and (remove_duplicates(str)).size == 8 and
    (match_triples(str[0, 12]) or
      match_triples(str[1, 12]) or
      match_triples(str[2, 12]) or
      match_triples(str[3, 12]) or
      match_triples(str[4, 12]))
end

def match_3plus1_X5(str)
  str.size == 20 and (remove_duplicates(str)).size == 10 and
    (match_triples(str[0, 15]) or
      match_triples(str[1, 15]) or
      match_triples(str[2, 15]) or
      match_triples(str[3, 15]) or
      match_triples(str[4, 15]) or
      match_triples(str[5, 15]))
end

def match_3plus2(str)
  match = (str.size == 5 and remove_duplicates(str).size == 2 and
    ((match_triple(str[0, 3]) and match_pair(str[3, 2])) or
      (match_triple(str[2, 3]) and match_pair(str[0, 2]))))

  if match
    return remove_pairs(str)[-1]
  end

  false
end

def match_3plus2s(str)
  match = (match_3plus2_X2(str) or
    match_3plus2_X3(str) or
    match_3plus2_X4(str))

  if match
    return remove_pairs(str)[-1]
  end

  false
end

def match_3plus2_X2(str)
  str.size == 10 and remove_duplicates(str).size == 4 and
    ((match_triples(str[0, 6]) and match_pair(str[6, 2]) and match_pair(str[8, 2])) or
      (match_triples(str[2, 6]) and match_pair(str[0, 2]) and match_pair(str[8, 2])) or
      (match_triples(str[4, 6]) and match_pair(str[0, 2]) and match_pair(str[2, 2])))
end

def match_3plus2_X3(str)
  str.size == 15 and remove_duplicates(str).size == 6 and
    ((match_triples(str[0, 9]) and match_pair(str[9, 2]) and match_pair(str[11, 2]) and match_pair(str[13, 2])) or
      (match_triples(str[2, 9]) and match_pair(str[0, 2]) and match_pair(str[11, 2]) and match_pair(str[13, 2])) or
      (match_triples(str[4, 9]) and match_pair(str[0, 2]) and match_pair(str[2, 2]) and match_pair(str[13, 2])) or
      (match_triples(str[6, 9]) and match_pair(str[0, 2]) and match_pair(str[2, 2]) and match_pair(str[4, 2])))
end

def match_3plus2_X4(str)
  str.size == 20 and remove_duplicates(str).size == 8 and
    ((match_triples(str[0, 12]) and match_pair(str[12, 2]) and match_pair(str[14, 2]) and match_pair(str[16, 2]) and match_pair(str[18, 2])) or
      (match_triples(str[2, 12]) and match_pair(str[0, 2]) and match_pair(str[14, 2]) and match_pair(str[16, 2]) and match_pair(str[18, 2])) or
      (match_triples(str[4, 12]) and match_pair(str[0, 2]) and match_pair(str[2, 2]) and match_pair(str[16, 2]) and match_pair(str[18, 2])) or
      (match_triples(str[6, 12]) and match_pair(str[0, 2]) and match_pair(str[2, 2]) and match_pair(str[4, 2]) and match_pair(str[18, 2])) or
      (match_triples(str[8, 12]) and match_pair(str[0, 2]) and match_pair(str[2, 2]) and match_pair(str[4, 2]) and match_pair(str[6, 2])))
end

$match_funcs = [
  Proc.new { |str| match_single(str) },
  Proc.new { |str| match_straight(str) },
  Proc.new { |str| match_pair(str) },
  Proc.new { |str| match_pairs(str) },
  Proc.new { |str| match_triple(str) },
  Proc.new { |str| match_triples(str) },
  Proc.new { |str| match_bomb(str) },
  Proc.new { |str| match_bomb_plus_2_singles(str) },
  Proc.new { |str| match_bomb_plus_2_pairs(str) },
  Proc.new { |str| match_nuke(str) },
  Proc.new { |str| match_3plus1(str) },
  Proc.new { |str| match_3plus1s(str) },
  Proc.new { |str| match_3plus2(str) },
  Proc.new { |str| match_3plus2s(str) },
]

def match_any(str)
  $match_funcs.each do |match_func|
    if match_func.call(str)
      return true
    end
  end

  false
end

def same_type(str_1, str_2)
  $match_funcs.each do |match_func|
    if match_func.call(str_1) and match_func.call(str_2) and str_1.length == str_2.length
      return true
    end
  end

  false
end

def key_value(str)
  $match_funcs.each do |match_func|
    ret = match_func.call(str)
    if ret
      return ret
    end
  end

  nil
end

def latter_bigger(str_1, str_2)
  if same_type(str_1, str_2) and key_value(str_2) > key_value(str_1)
    return true
  end

  if match_bomb(str_2) and not match_bomb(str_1) and not match_nuke(str_1)
    return true
  end

  if match_nuke(str_2) and not match_nuke(str_1)
    return true
  end

  false
end

def follow_rules(cards, cards_to_beat)
  if cards_to_beat == nil
    if match_any(cards.values)
      return true
    else
      return false
    end
  end

  if latter_bigger(cards_to_beat.values, cards.values)
    return true
  end

  false
end