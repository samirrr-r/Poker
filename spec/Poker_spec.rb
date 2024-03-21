RSpec.describe Card do
  context "Displays a card" do
    let(:a_card) {Card.new("Hearts", 9)}
    it "shows what the card is" do
      expect(a_card.show).to eq("9 of Hearts")
    end
    it "Shows the Joker correctly" do
      joker = Card.new("Joker", 0)
      expect(joker.show).to eq("Joker")
    end
    it "Shows the rank of a card" do
      expect(a_card.value_to_rank).to eq("9")
    end
  end
end

RSpec.describe Deck do
  let(:fresh_deck) {Deck.new()}
  context "Shuffle" do
    it "Shufffles a deck of 53 cards" do
      expect(fresh_deck.deck).not_to eq(fresh_deck.shuffle)
    end
  end
  context "Deal Cards" do
    it "Deals x cards to specified players" do
      size = fresh_deck.num_of_cards
      x = 5
      expect(fresh_deck.deal(5)).not_to include(fresh_deck.deck)
    end
  end
  it "returns the amount of cards in the deck" do
    expect(fresh_deck.num_of_cards).to eq(fresh_deck.deck.size)
  end
end

RSpec.describe Hand do
  let(:flush_hand) {Hand.new(Card.new("Hearts", 9), Card.new("Hearts", 9), Card.new("Hearts", 11),
  Card.new("Hearts", 11) ,Card.new("Hearts", 12))}

  let(:two_pair_hand) {Hand.new(Card.new("Hearts", 9), Card.new("Hearts", 9), Card.new("Hearts", 11),
  Card.new("Hearts", 11) ,Card.new("Hearts", 12))}

  let(:three_pair_hand) {Hand.new(Card.new("Hearts", 9), Card.new("Hearts", 9), Card.new("Hearts", 2),
  Card.new("Hearts", 11) ,Card.new("Hearts", 9))}

  let(:straight_hand) {Hand.new(Card.new("Hearts", 9), Card.new("Hearts", 8), Card.new("Hearts", 7),
  Card.new("Hearts", 10) ,Card.new("Hearts", 6))}

  let(:full_hand) {Hand.new(Card.new("Hearts", 9), Card.new("Hearts", 10), Card.new("Hearts", 9),
  Card.new("Hearts", 9) ,Card.new("Hearts", 10))}

  let(:four_hand) {Hand.new(Card.new("Hearts", 10), Card.new("Hearts", 10), Card.new("Hearts", 9),
  Card.new("Hearts", 10) ,Card.new("Hearts", 10))}

  let(:royal_hand) {Hand.new(Card.new("Hearts", 1), Card.new("Hearts", 10), Card.new("Hearts", 11),
  Card.new("Hearts", 12) ,Card.new("Hearts", 13))}
  context "Different Hand Rankings" do
    it "returns true when there is a flush" do
      expect(flush_hand.is_flush?).to eq(true)
    end
    it "returns true if the hand is a pair" do
      expect(flush_hand.is_pair?).to eq(true)
    end
    it "returns true if the hand is a two pair" do
      expect(two_pair_hand.is_two_pair?).to eq(true)
    end
    it "returns true if the hand is a three of a kind" do
      expect(three_pair_hand.is_three_of_kind?).to eq(true)
    end
    it "returns true if the hand is a straight" do
      expect(straight_hand.is_straight?).to eq(true)
    end
    it "returns true if the hand is a full house" do
      expect(full_hand.is_full_house?).to eq(true)
    end
    it "returns true if the hand is a four of a kind" do
      expect(four_hand.is_four_kind?).to eq(true)
    end
    it "returns if a hand is a straight flush" do
      expect(straight_hand.is_straight_flush?).to eq(true)
    end
    it "returns if a hand is a royal flush" do
      expect(royal_hand.is_roayl_flush?).to eq(true)
    end
    it "returns the high hand" do
      expect(straight_hand.high_card).to eq(10)
    end
    it "returns the ranking of the hand" do
      expect(full_hand.strength).to eq("Full house")
    end
  end
end
