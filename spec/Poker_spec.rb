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
