class CalculatorService
  class CalculationError < StandardError; end

  ERROR_MESAGE_CHARACTERS = 'The expression contains unpermitted characters'
  ERROR_MESAGE_SYNTAX = 'There is an issue with syntax'
  ERROR_MESAGE_BY_ZERO = 'You can not devide by zero'

  attr_reader :expression, :result

  def initialize(expression)
    @expression = expression
  end

  def call
    raise CalculationError.new(ERROR_MESAGE_CHARACTERS) if unpermitted_expression?

    begin
      @result = eval(expression)
    rescue SyntaxError
      raise CalculationError.new(ERROR_MESAGE_SYNTAX)
    rescue ZeroDivisionError
      raise CalculationError.new(ERROR_MESAGE_BY_ZERO)
    end
  end

  private

  def unpermitted_expression?
    return true if expression.include?('.')

    !expression.match?(/[0-9\+\-\*\/]/)
  end
end
