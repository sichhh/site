RSpec.describe Articles::Create, type: :interactor do
  it "is an Interactor::Organizer" do
    expect(Articles::Create).to be < Interactor::Organizer
  end

  it "organizes Prepare and Save interactors" do
    expect(Articles::Create.organized).to eq([Articles::Create::Prepare, Articles::Save])
  end

  it 'calls the interactors' do
    expect(Articles::Create::Prepare).to receive(:call!).ordered
    expect(Articles::Save).to receive(:call!).ordered
    described_class.call
  end
end
