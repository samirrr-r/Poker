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
    @cards = @deck.pop(amount)
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
