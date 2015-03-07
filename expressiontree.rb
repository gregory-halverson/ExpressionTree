module ExpressionTree
  class Expression
    def initialize(operation, operands)
      @operation = operation
      @operands = operands
    end

    def operation
      @operation
    end

    def operands
      @operands
    end

    def evaluate_operands
      @operands.collect { |operand| operand.is_a?(Expression) ? operand.evaluate : operand }
    end

    def evaluate
      self.evaluate_operands
    end

    def numeric_operands?
      @operands.all? { |operand| operand.is_a? Numeric }
    end
  end

  class Constant
    def initialize(constant)
      @operation = :constant
      @constant = constant
    end

    def operands
      @constant
    end

    def to_s
      @constant.to_s
    end
  end

  class Sum < Expression
    def initialize(operands)
      @operation = :sum
      @operands = operands
    end

    def evaluate
      evaluated = Sum.new(self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.operands.inject(:+) : evaluated
    end

    def to_s
      '(' + @operands.join(' + ') + ')'
    end
  end

  class Subtraction < Expression
    def initialize(operands)
      @operation = :subtraction
      @operands = operands
    end

    def evaluate
      evaluated = Subtraction.new(self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.operands.inject(:-) : evaluated
    end

    def to_s
      '(' + @operands.join(' - ') + ')'
    end
  end

  class Multiplication < Expression
    def initialize(operands)
      @operation = :multiplication
      @operands = operands
    end

    def evaluate
      evaluated = Multiplication.new(self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.operands.inject(:*) : evaluated
    end

    def to_s
      '(' + @operands.join(' * ') + ')'
    end
  end

  class Division < Expression
    def initialize(operands)
      @operation = :multiplication
      @operands = operands
    end

    def evaluate
      evaluated = Division.new(self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.operands.inject(:/) : evaluated
    end

    def to_s
      '(' + @operands.join(' / ') + ')'
    end
  end

  def sum(*operands)
    Sum.new operands
  end

  def sub(*operands)
    Subtraction.new operands
  end

  def mul(*operands)
    Multiplication.new operands
  end

  def div(*operands)
    Division.new operands
  end
end
