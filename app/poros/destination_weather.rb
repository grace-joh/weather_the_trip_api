class DestinationWeather
  attr_reader :datetime, :temperature, :conditions

  def initialize(datetime, temperature, conditions)
    @datetime = datetime
    @temperature = temperature
    @conditions = conditions
  end
end
