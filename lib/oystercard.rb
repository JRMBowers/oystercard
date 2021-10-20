class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end
  
  def in_journey?
    @in_journey
  end

  def touch_in
    fail "insufficient balance" unless @balance > MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_journey = false
  end

  private
  def deduct(amount)
    @balance -= amount
  end  
end