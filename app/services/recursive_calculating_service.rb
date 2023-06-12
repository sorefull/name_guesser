# frozen_string_literal: true

class RecursiveCalculatingService
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def call
    apply('*')
    apply('/')
    apply('+')
    apply('-')

    expression
  end

  def apply(method)
    # gets the index of the operator
    index = expression.index(method)
    # in case of - find the next - in the expression
    index = expression[1..-1].index(method).try(:+, 1) if index == 0

    return unless index

    # save two operands with - if there is one
    operand_one = expression[0..(index - 1)].scan(/-?\d+$/).first
    operand_two = expression[(index)..-1].scan(/-?\d+/).first

    # in case of - method this is happening: 2 - 2 becomes 2 + -2
    if method == '-'
      result = operand_one.to_i + operand_two.to_i
    else
      result = operand_one.to_i.send(method, operand_two.to_i)
    end

    # I collect the rest of the expresison and insurt the result into it
    sub_expression_one = index - operand_one.length == 0 ? '' : expression[0..(index - 1 - operand_one.length)]
    sub_expression_two = index + operand_two.length >= expression.length ? '' : expression[(index + 1 + operand_two.length)..-1]
    @expression = sub_expression_one + result.to_s + sub_expression_two

    # because i love recursion
    apply(method)
  end
end
