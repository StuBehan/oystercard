class Oystercard
  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :default_maximum, :entry_station, :station_history, :exit_station

  def initialize(balance = 0, default_maximum = DEFAULT_MAXIMUM)
    @balance = balance
    @default_maximum = default_maximum
    @entry_station = nil
    @exit_station = nil
    @station_history = []
  end

  def top_up(money)
    fail "Top-up exceeds the predetermined maximum" if @balance + money > @default_maximum
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
    touched_in_at(station)
  end

  def touched_in_at(station)
    @entry_station = station
  end

  def touch_out(station)
    deduct(DEFAULT_MINIMUM)
    @exit_station = station
    @station_history << save_journey
    @entry_station = nil
  end

  private

  def save_journey
    { :entry_station => @entry_station, :exit_station => @exit_station }
  end
  
  def in_journey?
    @entry_station != nil
  end

  def deduct(money)
    fail "The deducted amount exceeds the total remaining balance" if @balance - money < 0
    @balance -= money
  end
end
