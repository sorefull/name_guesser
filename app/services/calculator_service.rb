# frozen_string_literal: true

class CalculatorService
  class CalculationError < StandardError; end

  ERROR_MESAGE_CHARACTERS = 'The expression contains unpermitted characters'
  ERROR_MESAGE_BY_ZERO = 'You can not devide by zero'

  attr_reader :expression, :result

  def initialize(expression)
    @expression = filter_expression(expression)
  end

  def call
    raise CalculationError, ERROR_MESAGE_CHARACTERS if unpermitted_expression?

    begin
      @result = RecursiveCalculatingService.new(expression).call
    rescue ZeroDivisionError
      raise CalculationError, ERROR_MESAGE_BY_ZERO
    end
  end

  private

  def unpermitted_expression?
    # for some reason the regex doesn't filter out . so i do early return
    return true if expression.include?('.')

    !expression.match?(%r{[0-9+\-*/]})
  end

  def filter_expression(expression)
    expression
      .gsub(/\++/, '+')
      .gsub(/\-+/, '-')
      .gsub(/\*+/, '*')
      .gsub(/\\+/, '\\')
  end
end
