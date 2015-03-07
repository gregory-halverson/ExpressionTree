module ExpressionTree
  class Expression
    def initialize
      @operation = nil
      @numeric_operator = nil
      @operands = nil
    end

    def operation
      @operation
    end

    def numeric_operator
      @numeric_operator
    end

    def operands
      @operands
    end

    def evaluate_operands
      @operands.collect { |operand| operand.is_a?(Expression) ? operand.evaluate : operand }
    end

    def evaluate
      evaluated = self.class.new(self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.operands.inject(self.numeric_operator) : evaluated
    end

    def numeric_operands?
      @operands.all? { |operand| operand.is_a? Numeric }
    end
  end



  class Sum < Expression
    def initialize(operands)
      @operation = :sum
      @numeric_operator = :+
      @operands = operands
    end

    def to_s
      '(' + @operands.join(' + ') + ')'
    end
  end

  class Subtraction < Expression
    def initialize(operands)
      @operation = :subtraction
      @numeric_operator = :-
      @operands = operands
    end

    def to_s
      '(' + @operands.join(' - ') + ')'
    end
  end

  class Multiplication < Expression
    def initialize(operands)
      @operation = :multiplication
      @numeric_operator = :*
      @operands = operands
    end

    def to_s
      '(' + @operands.join(' * ') + ')'
    end
  end

  class Division < Expression
    def initialize(operands)
      @operation = :multiplication
      @numeric_operator = :/
      @operands = operands
    end

    def to_s
      '(' + @operands.join(' / ') + ')'
    end
  end

  class Exponentiation < Expression
    def initialize(base, exponent)
      @operation = :exponentiation
      @operands = [base, exponent]
    end

    def base
      @operands[0]
    end

    def exponent
      @operands[1]
    end

    def evaluate
      evaluated = Exponent.new(self.evaluate_operands)
      evaluated.numeric_operands? ? base ** exponent : evaluated
    end

    def to_s
      "#{base}^#{exponent}"
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

  def exp(base, exponent)
    Exponentiation.new base, exponent
  end
end
