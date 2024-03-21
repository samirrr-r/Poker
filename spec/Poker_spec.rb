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
