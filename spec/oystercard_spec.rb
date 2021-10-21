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

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end
  
  describe '#touch_in' do
    it "can touch in" do
      subject.top_up(2)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "raise error when insufficient balance" do
      expect { subject.touch_in(station) }.to raise_error "insufficient balance"
    end 

    it 'returns station when touch in' do 
      subject.top_up(2)
      subject.touch_in(station)
      expect(subject.station_touch_in).to eq station
    end 
  end

  describe '#touch_out' do
  let(:journey_double) {double("Journey double", :add_station_in => station, :add_station_out => exit_station)}

    before(:each) do 
      subject.top_up(10)
      subject.touch_in(station)
    end 
    it "can touch out" do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'expect touch_out to reduce balance' do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'touch out returns touch in station to nil' do
      subject.touch_out(exit_station)
      expect(subject.station_touch_in).to eq nil
    end 

  end

end