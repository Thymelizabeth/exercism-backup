class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    if @line[1] == ?I then
      @line[8..-1].strip
    elsif @line[1] == ?W then
      @line[11..-1].strip
    elsif @line[1] == ?E then
      @line[9..-1].strip
    end
  end

  def log_level
    @line.split("]")[0][1..-1].downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
