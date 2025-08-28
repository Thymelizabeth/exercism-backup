class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    if !first_operand.kind_of?(Integer) || !second_operand.kind_of?(Integer) then
      raise ArgumentError.new
    end
    return case operation
      when "*" then "#{first_operand} * #{second_operand} = #{first_operand * second_operand}"
      when "+" then "#{first_operand} + #{second_operand} = #{first_operand + second_operand}"
      when "/" then begin
        "#{first_operand} / #{second_operand} = #{first_operand / second_operand}"
      rescue
        "Division by zero is not allowed."
      end
      else
      raise UnsupportedOperation.new("#{operation} is not supported")
    end
  end
end
