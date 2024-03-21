class Card
  attr_reader :suit, :value, :suit_list, :value_list
  @@suit_list = ["Hearts", "Spades", "Diamonds", "Clubs"]
  @@value_list = {0=> "Joker", 1 => "Ace", 2 => "2" , 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "10",
                11 => "Jack", 12 => "Queen", 13 => "King"}

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def show
    if @suit != "Joker"
        "#{@@value_list[@value]} of #{@suit}"
    else
      "Joker"
    end
  end
  def value_to_rank
    @@value_list[@value]
  end
end

class Deck < Card
  attr_reader :deck, :cards
  def initialize
    @deck = [Card.new("Joker", 0)]
    @@suit_list.each  do |type|
      @@value_list.each do |key, val|
        if key==0
          next
        end
        @deck << Card.new(type, val)
      end
    end
    shuffle
  end

  def shuffle
    @deck = @deck.to_a.shuffle
  end

  def deal(amount)
    @deck.pop(amount)
  end

  def num_of_cards
    @deck.size
  end

  def show_deck
    @deck.each do |card|
      puts card.show
    end
  end
end

class Hand < Deck
  attr_accessor :card1, :card2, :card3, :card4, :card5
  @@hand_strength = ["Royal Flush","Straight flush","Four of a kind", "Full house", "Flush", "Straight",
                    "Three of a kind", "Two pair", "One pair", "High card"]
  def initialize(card1, card2, card3, card4, card5)
    @card_list = [card1, card2, card3, card4, card5]
    @val_list = [card1.value, card2.value, card3.value, card4.value, card5.value]
    @suit_list = [card1.suit, card2.suit, card3.suit, card4.suit, card5.suit]
    @sorted_val_list = @val_list.sort
    @len = @card_list.length
  end



  def strength()
    if is_roayl_flush?
      return @@hand_strength[0]
    elsif is_straight_flush?
      return @@hand_strength[1]
    elsif is_four_kind?
      return @@hand_strength[2]
    elsif is_full_house?
      return @@hand_strength[3]
    elsif is_flush?
      return @@hand_strength[4]
    elsif is_straight?
      return @@hand_strength[5]
    elsif is_three_of_kind?
      return @@hand_strength[6]
    elsif is_two_pair?
      return @@hand_strength[7]
    elsif is_pair?
      return @@hand_strength[8]
    else
      return high_card
    end

  end

  def is_flush?
    @card_list.all? { |x| x.suit == @card_list[0].suit}
  end

  def is_straight?
    (@len-1).times do |i|
      if @sorted_val_list[i]+1 != @sorted_val_list[i+1]
        return false
      end
    end
    return true
  end

  def is_roayl_flush?
    if is_flush?
      if ((@sorted_val_list[0] == 1) && (@sorted_val_list[1] == 10) && (@sorted_val_list[2] == 11) &&
        (@sorted_val_list[3] == 12) && (@sorted_val_list[4] == 13))
        return true
      end
    end
    return false
  end

  def is_straight_flush?
    if is_straight?
      if is_flush?
        return true
      end
    end
  end

  def is_four_kind?
    @len.times do |i|
    occur = 1
    check = @val_list[i]
      j = i+1
      (@len-i-1).times do
        if @val_list[i] == @val_list[j]
          occur +=1
          if occur == 4
            return true
          end
        end
        j +=1
      end
    end
    return false
  end

  def is_full_house?
    if @sorted_val_list[0] == @sorted_val_list[1] && @sorted_val_list[1] == @sorted_val_list[2]
      if @sorted_val_list[3]==  @sorted_val_list[4]
        return true
      end
    elsif @sorted_val_list[0]==  @sorted_val_list[1]
      if @sorted_val_list[2] == @sorted_val_list[3] && @sorted_val_list[3] == @sorted_val_list[4]
        return true
      end
    end
    return false
  end

  def is_three_of_kind?
    occur = 0
    @len.times do |i|
      j = i+1
      (@len-i-1).times do
        if @val_list[i] == @val_list[j]
          occur +=1
          if occur == 3
            return true
          end
        end
        j +=1
      end
    end
    return false
  end

  def is_two_pair?
    occur = 0
    @len.times do |i|
      j = i+1
      (@len-i-1).times do
        if @val_list[i] == @val_list[j]
          occur +=1
          if occur == 2
            return true
          end
        end
        j +=1
      end
    end
    return false
  end

  def is_pair?
    @len.times do |i|
      j = i+1
      (@len-1).times do
        if @val_list[i] == @val_list[j]
          return true
        end
        j +=1
      end
    end
    return false
  end

  def high_card
    return @sorted_val_list[4]
  end

  def show_hand
    @card_list.length.times do |x|
      puts "#{x}. #{card_list[x].show}"
    end
    puts
  end
end
class Player < Hand
  attr_accessor :hand, :bet, :choice
  attr_reader :rank
  @@choices = {1 => "bet", 2 => "fold", 3 => "raise"}
  def initialize(name)
    @name = name
    @hand = nil
    @bet = 0
    @fold = false
    @choice = nil
  end

  def decision
    puts "#{@name} do you want to 1: bet\n2: fold\n3: raise?"
    choice = 3
    if choice>3
      choice=3
    elsif choice<0
      choice = 0
    end
    return @@choices[choice]
  end

  def see
    hand.show_hand
  end

  def discard
    see
    puts "#{@name} how many cards do you want to discard 0-3?"
    @disc = 3
    if @disc>3
      @disc=3
    elsif disc<0
      @disc = 0
    end
    return @disc
  end
end
