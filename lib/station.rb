
class Station
  attr_reader :name, :zone
  def initialize(name_zone) 
    @zone = name_zone[:zone]
    @name = name_zone[:name]
  end
end