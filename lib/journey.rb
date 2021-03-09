class Journey

  attr_reader :complete_journey

  def initialize 
    @complete_journey = { :entry_station => nil, :exit_station => nil }
  end

  def start_journey(station)
    @complete_journey[:entry_station] = station
  end 

  def end_journey(station)
    @complete_journey[:exit_station] = station
  end 

  def complete?
    !@complete_journey.has_value?(nil)
  end 
end 
