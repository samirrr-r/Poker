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
