require 'journey'
require 'station'

describe Journey do 
  let(:journey) { Journey.new }
  let(:station) { Station.new }

  describe 'start_journey' do
    it { is_expected.to respond_to(:start_journey).with(1).argument }
    it 'returns the station' do 
      expect(journey.start_journey(station)).to eq station
    end 
  end 

  describe 'end_journey' do
    it { is_expected.to respond_to :end_journey }
    it 'should return the station' do 
      expect(journey.end_journey(station)).to eq station
    end 
  end 

  describe 'complete journey should see the entry station and the exit station' do 
    it 'should put the start and end station into the complete journey' do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.complete_journey).to eq({ :entry_station => station, :exit_station => station })
    end 
  end 

  describe 'complete?' do 
    it { is_expected.to respond_to :complete? }
    it 'should return false if journey incomplete' do 
      expect(journey.complete?).to eq false
    end 
  end 
end
