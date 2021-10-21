require 'oystercard'
require 'journey'

class Journey
attr_reader :journey_history, :station_in, :station_out

def initialize
  @journey_history = []
  @station_in = nil
  @station_out = nil
end 

def add_station_in(station)
  @station_in = station
end 

def add_station_out(station)
  @station_out = station
  finished_journey
end

def finished_journey
  @journey_history << {@station_in => @station_out}
  reset
end 
  
#private

def reset
  @station_out = nil
  @station_in = nil
end 

def finish
end 

def fare
end 

def complete?
  !!station_in && !!station_out
end 


end