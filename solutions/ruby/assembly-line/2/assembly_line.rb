class AssemblyLine

  CARS_PER_HOUR = 221.0
  SUCCESS_RATE_5_8 = 0.9
  SUCCESS_RATE_9 = 0.8
  SUCCESS_RATE_10 = 0.77
  MINUTES_PER_HOUR = 60
  
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    if @speed <= 4 then
      @speed * CARS_PER_HOUR
    elsif @speed <= 8 then
      @speed * CARS_PER_HOUR * SUCCESS_RATE_5_8
    elsif @speed == 9 then
      @speed * CARS_PER_HOUR * SUCCESS_RATE_9
    elsif @speed == 10 then
      @speed * CARS_PER_HOUR * SUCCESS_RATE_10
    else
      raise 'Invalid speed'
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / MINUTES_PER_HOUR).floor
  end
end
