require 'station'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :station_touch_in, :exit_station, :station, :journey_history

  def initialize
    @balance = 0
    @station_touch_in = nil
    @journey_history = []
    @exit_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end
  
  def in_journey?
    !!station_touch_in
  end

  def touch_in(station)
    @station_touch_in = station
    fail "insufficient balance" unless @balance > MINIMUM_BALANCE
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @exit_station = exit_station
    store_station
    @station_touch_in = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end  

  def store_station
    @journey_history << {@station_touch_in => @exit_station}
    reset_station_exit_station
  end 

  def reset_station_exit_station
    @station_touch_in = nil
    @exit_station = nil
  end 
end