RSpec.describe Articles::Update, type: :interactor do
  it "organizes the Save interactor" do
    expect(Articles::Update.organized).to eq([Articles::Save])
  end

  it "calls the Save interactor" do
    expect(Articles::Save).to receive(:call!).ordered
    described_class.call
  end
end
