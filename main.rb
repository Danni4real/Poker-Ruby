# frozen_string_literal: true

require_relative 'Card'
require_relative 'Cards'
require_relative 'Rules'
require_relative 'Robot'

def new_deck
  Cards.new([Card.new('3', SPADE), Card.new('3', HEART), Card.new('3', CLUB), Card.new('3', DIAMOND),
             Card.new('4', SPADE), Card.new('4', HEART), Card.new('4', CLUB), Card.new('4', DIAMOND),
             Card.new('5', SPADE), Card.new('5', HEART), Card.new('5', CLUB), Card.new('5', DIAMOND),
             Card.new('6', SPADE), Card.new('6', HEART), Card.new('6', CLUB), Card.new('6', DIAMOND),
             Card.new('7', SPADE), Card.new('7', HEART), Card.new('7', CLUB), Card.new('7', DIAMOND),
             Card.new('8', SPADE), Card.new('8', HEART), Card.new('8', CLUB), Card.new('8', DIAMOND),
             Card.new('9', SPADE), Card.new('9', HEART), Card.new('9', CLUB), Card.new('9', DIAMOND),
             Card.new('10', SPADE), Card.new('10', HEART), Card.new('10', CLUB), Card.new('10', DIAMOND),
             Card.new('J', SPADE), Card.new('J', HEART), Card.new('J', CLUB), Card.new('J', DIAMOND),
             Card.new('Q', SPADE), Card.new('Q', HEART), Card.new('Q', CLUB), Card.new('Q', DIAMOND),
             Card.new('K', SPADE), Card.new('K', HEART), Card.new('K', CLUB), Card.new('K', DIAMOND),
             Card.new('A', SPADE), Card.new('A', HEART), Card.new('A', CLUB), Card.new('A', DIAMOND),
             Card.new('2', SPADE), Card.new('2', HEART), Card.new('2', CLUB), Card.new('2', DIAMOND),
             Card.new('B'), Card.new('R')])
end

new_deck_of_cards = new_deck
new_deck_of_cards.shuffle

player_1_cards = new_deck_of_cards.pop(17).sort
player_2_cards = new_deck_of_cards.pop(17).sort
landlord_cards = new_deck_of_cards.pop(20).sort

player_list = [landlord_cards, player_1_cards, player_2_cards]
i = loop_from_0_to_2

cards_to_beat = nil
pass_rounds = 0

while true
  if pass_rounds == 2
    cards_to_beat = nil
  end

  sleep 2

  if i == 0
    puts "\n\nCards in your hand:"
    player_list[i].print
    played_cards = get_usr_input_cards
  else
    played_cards = robot_play(player_list[i], cards_to_beat)
  end

  puts "Player #{i}:"

  if played_cards != nil
    played_cards.print
  else
    puts "Pass"
  end

  if played_cards == nil
    if pass_rounds == 2
      puts "invalid play, play again!"
      next
    end

    pass_rounds += 1
    i = loop_from_0_to_2
    next
  else
    pass_rounds = 0
    played_cards = played_cards.sort
  end

  if player_list[i].contains(played_cards) and follow_rules(played_cards, cards_to_beat)
    cards_to_beat = played_cards
    player_list[i].remove(played_cards)

    if player_list[i].card_list.length == 0
      puts "You Win!!!"
      sleep 2
      puts "Player 1 remain cards:"
      player_1_cards.print
      
      puts "Player 2 remain cards:"
      player_2_cards.print
      break
    end

    i = loop_from_0_to_2
  else
    puts "invalid play, play again!"
    next
  end

end