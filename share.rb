# frozen_string_literal: true

RED = 0
BLACK = 1

HEART = '♥'
DIAMOND = '♦'
CLUB = '♣'
SPADE = '♠'
JOKER = '☺'

CARD_MAP = { "3" => 'a', "4" => 'b', "5" => 'c', "6" => 'd', "7" => 'e', "8" => 'f', "9" => 'g', "10" => 'h',
             "J" => 'i', "Q" => 'j', "K" => 'k', "A" => 'l', "2" => 'n', "B" => 'p', "R" => 'r' }

def red(name)
  if name == '10'
    "\e[38;5;160;48;5;15m #{name}\e[0m"
  else
    "\e[38;5;160;48;5;15m #{name} \e[0m"
  end
end

def black(name)
  if name == '10'
    "\e[38;5;0;48;5;15m #{name}\e[0m"
  else
    "\e[38;5;0;48;5;15m #{name} \e[0m"
  end
end

def print_white_blocks(number)
  number.times { Kernel.print "\e[48;2;255;255;255m   \e[0m" }
end

def newline
  puts ""
end

def get_usr_input_cards
  tmp = gets.chomp
  tmp.gsub!('0', '')
  tmp = tmp.chars.map { |char| char == '1' ? '10' : char }
  cards = []
  tmp.each do |name|
    cards << Card.new(name)
  end

  if cards.length == 0
    return nil
  end

  Cards.new(cards)
end

def loop_from_0_to_2
  @i ||= -1

  @i += 1
  if @i == 3
    @i = 0
  end

  @i
end