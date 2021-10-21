require 'station'
require 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 5
  attr_reader :balance, :station

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "insufficient balance" unless @balance > MINIMUM_BALANCE
    result = @journey.add_station_in(station)
    deduct(PENALTY) if result == "fare"
    result
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    result = @journey.add_station_out(exit_station)
    deduct(PENALTY) if result == "fare"
    result
  end

  private
  def deduct(amount)
    @balance -= amount
  end  

end