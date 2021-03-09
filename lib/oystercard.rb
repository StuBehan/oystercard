require 'journey'

class Oystercard
  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :default_maximum, :entry_station, :station_history, :exit_station, 
              :current_journey

  def initialize(balance = 0, default_maximum = DEFAULT_MAXIMUM)
    @balance = balance
    @default_maximum = default_maximum
    @station_history = []
    @current_journey = Journey.new
  end

  def top_up(money)
    fail "Top-up exceeds the predetermined maximum" if @balance + money > @default_maximum

    @balance += money
  end

  def touch_in(station)
    @current_journey.start_journey(station)
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
  end

  def touch_out(station)
    @current_journey.end_journey(station)
    deduct(fare)
    save_journey
  end

  def fare 
    @current_journey.complete? ? DEFAULT_MINIMUM : 6 
  end 

  private

  def save_journey
    @station_history << @current_journey.complete_journey
  end

  def deduct(money)
    fail "The deducted amount exceeds the total remaining balance" if (@balance - money).negative?

    @balance -= money
  end
end
