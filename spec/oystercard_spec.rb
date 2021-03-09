require 'oystercard'
require 'station'
require 'journey'

describe Oystercard do
  let(:test_card) { Oystercard.new(20) }
  let(:station) { Station.new }
  let(:journey) { Journey.new }
  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  it 'current_journey creates a journey om initialization' do 
    expect(subject.current_journey).to be_a Journey
  end 

  it "station_history is empty on initialization" do 
    expect(subject.station_history).to eq []
  end

  describe 'top_up' do
    it "will add money to the balance of the card" do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
    it "will return an error if the total would exceed the default maximum" do
      expect { subject.top_up(1 + subject.default_maximum) }.to raise_error("Top-up exceeds the predetermined maximum")
    end
  end

  describe 'touch_in' do

    it 'will return an error if the card has less than £1 balance' do
      expect { subject.touch_in(station) }.to raise_error("Not enough money to touch in")
    end
  end

  describe 'touch_out' do
    it 'should update station history' do
      expect { test_card.touch_out(station) }.to change { test_card.station_history.count }.by 1
    end 

    it "touching out deducts the minimum fare" do
      test_card.touch_in(station)
      expect { test_card.touch_out(station) }.to change { test_card.balance }.by -Oystercard::DEFAULT_MINIMUM
    end

    it "will return an error if the deducted amount exceeds the total remaining" do
      expect { subject.touch_out(station) }.to raise_error("The deducted amount exceeds the total remaining balance") 
    end
  end

  describe 'save_journey' do
    let(:entry_station) { Station.new }
    it "saves the journey details as a hash" do
      test_card.touch_in(entry_station)
      test_card.touch_out(station)
      expect( test_card.station_history ).to include( { :entry_station => entry_station, :exit_station => station } )
    end
  end

  describe 'fare' do 
    it { is_expected.to respond_to :fare }
    it 'returns a fine if journey is incomplete' do 
      expect( test_card.fare ).to eq 6
    end 
  end 
end

# In order to use public transport
# As a customer
# I want money on my card

# In order to keep using public transport
# As a customer
# I want to add money to my card

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

# In order to pay for my journey
# As a customer
# I need my fare deducted from my card

# In order to get through the barriers.
# As a customer
# I need to touch in and out.

# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.

# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card