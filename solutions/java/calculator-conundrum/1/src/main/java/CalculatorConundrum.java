class CalculatorConundrum {
    public String calculate(int operand1, int operand2, String operation) {
	try {
	    switch (operation) {
	    case "+":
		return operand1 + " + " + operand2 + " = " + (operand1 + operand2);
	    case "*":
		return operand1 + " * " + operand2 + " = " + (operand1 * operand2);
	    case "/":
		return operand1 + " / " + operand2 + " = " + (operand1 / operand2);
	    case "":
		throw new IllegalArgumentException("Operation cannot be empty");
	    case null:
		throw new IllegalArgumentException("Operation cannot be null");
	    default:
		throw new IllegalOperationException("Operation '" + operation + "' does not exist");
	    }
	}
	catch (ArithmeticException divByZeroException) {
	    throw new IllegalOperationException("Division by zero is not allowed", divByZeroException);
	}
    }
}
