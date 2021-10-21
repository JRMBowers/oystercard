require 'station'
require 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :station_touch_in, :exit_station, :station

  def initialize(journey = Journey.new)
    @balance = 0
    @station_touch_in = nil
    @exit_station = nil
    @journey = journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end
  
  def in_journey?
    !!station_touch_in
  end

  def touch_in(station)
    fail "insufficient balance" unless @balance > MINIMUM_BALANCE
    @journey.add_station_in(station)
    @station_touch_in = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @exit_station = exit_station
    @station_touch_in = nil
    @journey.add_station_out(station)
  end

  private
  def deduct(amount)
    @balance -= amount
  end  

end