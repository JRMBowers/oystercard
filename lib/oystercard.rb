class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :station_touch_in

  def initialize
    @balance = 0
    @station_touch_in = nil
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

  def touch_out
    deduct(MINIMUM_BALANCE)
    @station_touch_in = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end  
end