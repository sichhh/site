RSpec.describe Articles::Create, type: :interactor do

  it "organizes Prepare and Save interactors" do
    expect(Articles::Create.organized).to eq([Articles::Create::PrepareParams, Articles::Save])
  end

  it 'calls the interactors' do
    expect(Articles::Create::PrepareParams).to receive(:call!).ordered
    expect(Articles::Save).to receive(:call!).ordered
    described_class.call
  end
end
