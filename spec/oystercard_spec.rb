require 'oystercard'
require 'journey'

describe Oystercard do
  let(:station){ double :station }
  let(:exit_station){ double :exit_station }
  let(:journey1){ {station => exit_station} }

  it 'has a balance' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument}
    it ' can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by(1) 
    end

    it 'raises n error if the maximum blance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  
  describe '#touch_in' do

    it "raise error when insufficient balance" do
      expect { subject.touch_in(station) }.to raise_error "insufficient balance"
    end 

    it 'returns station when touch in' do 
      journey_double = double("double add_station_in", add_station_in: station)
      oystercard = Oystercard.new(journey_double)
      oystercard.top_up(2)
      expect(oystercard.touch_in(station)).to eq station
    end 

    it 'fare is given for double touch in' do 
      journey_double = double("add_touch_in", add_station_in: "fare")
      oystercard = Oystercard.new(journey_double) 
      oystercard.top_up(10)
      expect { oystercard.touch_in(station) }.to change{ oystercard.balance }.by -5
    end 
  end

  describe '#touch_out' do
  let(:journey_double) {double("Journey double", add_station_in: station, add_station_out: journey1)}

    before(:each) do 
      subject.top_up(10)
      subject.touch_in(station)
    end 

    it "can touch out" do
      oystercard = Oystercard.new(journey_double)
      oystercard.top_up(10)
      oystercard.touch_in(station)
      expect(oystercard.touch_out(exit_station)).to eq journey1
    end

    it 'expect touch_out to reduce balance' do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'fare is given for double touch out' do 
      journey_double = double("add_touch_out", add_station_out: "fare")
      oystercard = Oystercard.new(journey_double) 
      oystercard.top_up(10)
      expect { oystercard.touch_out(station) }.to change{ oystercard.balance }.by -6
    end 

  end

end