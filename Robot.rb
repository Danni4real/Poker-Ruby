# frozen_string_literal: true
require_relative 'Card'
require_relative 'Cards'
require_relative 'Rules'

def robot_play(cards_inhand, cards_to_beat)

  cards_inhand.size.downto(1) do |size|
    10000.times do
      candidate_cards = Cards.new(cards_inhand.card_list.sample(size))
      if follow_rules(candidate_cards, cards_to_beat)
        return candidate_cards
      end
    end
  end

  return nil
end