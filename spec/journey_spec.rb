require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end 

  # it 'expect touch out to store journey' do 
  #   my_card = Oystercard.new(journey_double)
  #   subject.touch_out(exit_station)
  #   expect(@journey.finished_journey).to include journey1
  # end 

end 

# describe '#store_station' do 
# 
#     it 'checks journey history starts out empty' do 
#       expect(subject.journey_history).to eq []
#     end 
# 
#   end 