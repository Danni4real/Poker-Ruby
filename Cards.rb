# frozen_string_literal: true

require_relative 'Card'
require_relative 'share'

class Cards
  def initialize(card_list)
    @m_card_list = card_list
  end

  def card_list
    @m_card_list
  end

  def [](index)
    @m_card_list[index]
  end

  def size
    @m_card_list.size
  end

  def values
    str = ""

    @m_card_list.each do |card|
      str += card.value
    end

    str
  end

  def print
    @m_card_list.each do |card|
      card.print_name
    end

    print_white_blocks(3)
    newline

    @m_card_list.each do |card|
      card.print_suit
    end

    print_white_blocks(3)
    newline

    n = 4
    n.times do
      @m_card_list.each { print_white_blocks(1) }
      print_white_blocks(3)
      newline
    end

    newline

    self
  end

  def shuffle
    @m_card_list = @m_card_list.shuffle
  end

  def pop(number)
    Cards.new(@m_card_list.shift(number))
  end

  def sort
    @m_card_list = @m_card_list.sort_by { |card| card.value }
    self
  end

  def remove(cards)
    cards.card_list.each do |card|
      index = @m_card_list.find_index(card)
      @m_card_list.delete_at(index) if index
    end

    self
  end

  def contains(cards)
    copy = Cards.new(self.card_list.clone)
    copy.remove(cards)
    copy.size == self.size - cards.size
  end

end