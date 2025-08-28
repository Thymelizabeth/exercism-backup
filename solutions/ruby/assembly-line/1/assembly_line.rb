class AssemblyLine

  CARS_PER_HOUR_1 = 221.0
  
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    if @speed <= 4 then
      @speed * CARS_PER_HOUR_1
    elsif @speed <= 8 then
      @speed * CARS_PER_HOUR_1 * 0.9
    elsif @speed == 9 then
      @speed * CARS_PER_HOUR_1 * 0.8
    elsif @speed == 10 then
      @speed * CARS_PER_HOUR_1 * 0.77
    else
      raise 'Invalid speed'
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
