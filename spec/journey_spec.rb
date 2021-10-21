require 'journey'

describe Journey do
  let(:station_in) { double [:station, :zone]}
  let(:station_out) {double [:station_out, :zone]}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end 

  describe '#add_station_out' do
  before(:each) do 
    subject.add_station_in(station_in)
  end 

  it "knows if journey is complete" do 
    expect {subject.add_station_out(station_out)}.to change{subject.complete?}.to be_truthy
  end 

  it 'expect touch out to store journey' do 
    expect {subject.add_station_out(station_out)}.to change{subject.journey_history}.to [station_in=>station_out]
  end 

end 

end 

# describe '#store_station' do 
# 
#     it 'checks journey history starts out empty' do 
#       expect(subject.journey_history).to eq []
#     end 
# 
#   end 