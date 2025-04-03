# frozen_string_literal: true

require_relative 'share'

class Card

  def initialize(name, suit = HEART)
    @name = name

    if @name == "B" or @name == "R"
      @suit = JOKER
    else
      @suit = suit
    end

    @value = CARD_MAP[@name]
    if @suit == JOKER
      @color = case @name
               when "B" then BLACK
               when "R" then RED
               end
    else
      @color = case @suit
               when CLUB then BLACK
               when SPADE then BLACK
               when HEART then RED
               when DIAMOND then RED
               end
    end
  end

  def ==(card)
    return false unless card.is_a?(Card)

    @value == card.value
  end

  def name
    @name
  end

  def value
    @value
  end

  def print_suit
    case @color
    when RED then Kernel.print red(@suit)
    when BLACK then Kernel.print black(@suit)
    end
  end

  def print_name
    case @color
    when RED then Kernel.print red(@name)
    when BLACK then Kernel.print black(@name)
    end
  end

end