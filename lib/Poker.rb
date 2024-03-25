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
        @deck << Card.new(type, key)
      end
    end
    shuffle
  end

  def shuffle
    @deck = @deck.to_a.shuffle
  end

  def deal(amount)
    if amount > 1
      @deck.pop(amount)
    else
      @deck.pop()
    end
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
  attr_accessor :card1, :card2, :card3, :card4, :card5, :card_list

  @@hand_strength = {:royalflush => 10,
                      :straightflush => 9,
                      :fourkind => 8,
                      :fullhouse => 7,
                      :flush => 6,
                      :straight => 5,
                      :threekind => 4,
                      :twopair => 3,
                      :onepair => 2,
                      :highcard => 1}
  def initialize(card1, card2, card3, card4, card5)
    @card1 = card1
    @card2 = card2
    @card3 = card3
    @card4 = card4
    @card5 = card5
    update
  end

  def update
    @card_list = [@card1, @card2, @card3, @card4, @card5]
    @val_list = [@card1.value, @card2.value, @card3.value, @card4.value, @card5.value]
    @suit_list = [@card1.suit, @card2.suit, @card3.suit, @card4.suit, @card5.suit]
    @sorted_val_list = @val_list.sort
    @len = @card_list.length
  end


  def strength()
    update
    if is_roayl_flush?
      return @@hand_strength[:royalflush]
    elsif is_straight_flush?
      return @@hand_strength[:straightflush]
    elsif is_four_kind?
      return @@hand_strength[:fourkind]
    elsif is_full_house?
      return @@hand_strength[:fullhouse]
    elsif is_flush?
      return @@hand_strength[:flush]
    elsif is_straight?
      return @@hand_strength[:straight]
    elsif is_three_of_kind?
      return @@hand_strength[:threekind]
    elsif is_two_pair?
      return @@hand_strength[:twopair]
    elsif is_pair?
      return @@hand_strength[:onepair]
    else
      return @@hand_strength[:highcard]
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

  def is_four_kind?#22
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

  def is_three_of_kind?#2
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

  def is_two_pair?#2
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

  def is_pair?#2
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
    update
    return @sorted_val_list[4]
  end

  def show_hand
    update
    puts
    @card_list.length.times do |x|
      puts "#{x+1}. #{@card_list[x].show}"
    end
    puts
  end
end
class Player < Hand
  attr_accessor :hand, :choice, :winnings, :fold, :name
  @@choices = {1 => "bet", 2 => "fold", 3 => "raise"}
  def initialize(name)
    @name = name
    @hand = nil
    @fold = false
    @choice = nil
    @disc = nil
    @winnings = 0
  end

  def decision
    #2
    see
    puts "#{@name} do you want to 1: bet\n2: fold\n3: raise?"
    @choice = gets.chomp.to_i
    if @choice>3
      @choice=3
    elsif @choice<0
      @choice = 0
    end
    return @@choices[@choice]
  end

  def see

    hand.show_hand
  end

  def discard
    see
    puts "#{@name} how many cards do you want to discard 0-3?"
    #1
    @disc = gets.chomp.to_i
    if @disc>3
      @disc=3
    elsif @disc<0
      @disc = 0
    end
    return @disc
  end

  def hand_rank
    hand.strength
  end

end
class Game < Player
  attr_accessor :bet, :pot, :players, :deck, :prev_bet, :players
  def initialize()
    @deck = Deck.new
    @bet = 0
    @pot = 0
    @players = []
    @prev_bet = 0
    @quit = false
  end

  def get_players
    puts "Enter in each player starting with the player that will start first and so on
          seperated by only a space"
    names = gets.chomp.split(" ")
    names.each do |name|
      @players << Player.new("#{name}")
    end
  end

  def new_hand
    @players.each do |player|
      c1, c2, c3, c4, c5 = deck.deal(5)
      player.hand = Hand.new(c1, c2, c3, c4, c5)
      player.hand.update
    end
  end

  def draw_round
    @players.each do |player|
      if player.fold == true
        next
      end
      card_to_discard = []
      player.discard.times do
        puts "Which card would wou like to discard.
              Type and press enter"
        card_to_discard << gets.chomp.to_i
      end
      card_to_discard.each do |card|
        case card
        when 1
          player.hand.card1 = deck.deal(1)
        when 2
          player.hand.card2 = deck.deal(1)
        when 3
          player.hand.card3 = deck.deal(1)
        when 4
          player.hand.card4 = deck.deal(1)
        when 5
          player.hand.card5 = deck.deal(1)
        end
      end
      player.hand.update
    end
  end

  def first_bet
    while @bet == 0 || @bet < 0
      puts "#{players[0].name} how much would you like to bet"
      @bet = gets.chomp.to_i
    end
      bets
  end

  def bets
    @pot += @bet
    @prev_bet = @bet
  end

  def raises
    until @bet >= @prev_bet+5
      puts "How much would you like to raise
            (must be 5 more than previous bet)"
      @bet = gets.chomp.to_i
    end
      bets
  end

  def quit_game
    puts "Do you all want to quit this game?(enter q to quit)"
    @quit = gets.chomp
    if @quit == "q" || @quit == "Q"
      @quit = true
    else
      @quit = false
    end
  end

  def show_winnings
    @players.each do |player|
      puts "#{player.name} you won $#{player.winnings}"
    end
  end

  def bet_round
    @players.each do |player|
      if player.fold == true
        next
      end
      case player.decision
      when @@choices[1]
        if @bet <= 0
          first_bet
        else
          bets
        end
      when @@choices[2]
        player.fold = true
      when @@choices[3]
        raises
      end
    end
  end

  #finds the winner of the round based on their hand ranking
  def winner_of_round
    winner = 0
    winner_lst = []
    @players.each do |player|
      if player.fold
        next
      end
      puts "#{player.name} your hand has a rank of #{player.hand.strength}"
      if player.hand.strength > winner
        winner_lst = []
        winner = player.hand.strength
        winner_lst << player
      elsif player.hand.strength == winner
        winner_lst << player
      end
    end

    #Breaks a tie if multiple people have the same rank. Breaks tie by highcard value
    if winner_lst.length>1
      highest_highcard = 0
      cur_winner = nil
      winner_lst.each do |win_player|
        if highest_highcard < win_player.hand.high_card
          highest_highcard = win_player.hand.high_card
          cur_winner = win_player
        end
      end
      cur_winner.winnings += @pot
      puts "#{cur_winner.name} you won the pot of#{@pot}"
    elsif winner_lst.length == 1
      puts "#{winner_lst[0].name} you won the pot of #{@pot}"
      winner_lst[0].winnings += @pot
    else
      puts "Nobody won"
    end
    #resets the pot when someone wins
    @pot = 0
  end

  #main method that starts the game
  def play
    get_players
    until @quit
      new_hand
      bet_round
      draw_round
      bet_round
      winner_of_round
      quit_game
    end

    show_winnings

  end
end


person = Player.new("name")
person.hand = Hand.new(Card.new("Hearts", 1), Card.new("Hearts", 10), Card.new("Hearts", 11),
  Card.new("Hearts", 12) ,Card.new("Hearts", 13))
deck = Deck.new
lst = [person, person, person]

per1 = person

c = 0
lst.each do |i|
  if c==0
    i.hand.card1 = Card.new("Hearts", 3)
    c += 1
  end
end

per2 = person
puts person.hand_rank
#per.hand.card1 = Card.new("Hearts", 3)

puts person.hand_rank
puts per1.hand_rank
puts per2.hand_rank
puts lst[2].hand_rank

game = Game.new
game.play
