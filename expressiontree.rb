module ExpressionTree
  class Expression
    def initialize
      @operation = nil
      @operator = nil
      @numeric_operator = nil
      @operands = nil
    end

    def operation
      @operation
    end

    def operator
      @operator
    end

    def numeric_operator
      @numeric_operator
    end

    def operands
      @operands
    end

    def evaluate_operands
      self.operands.collect { |operand| operand.is_a?(Expression) ? operand.evaluate : operand }
    end

    def evaluate
      evaluated = self.class.new(self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.operands.inject(self.numeric_operator) : evaluated
    end

    def numeric_operands?
      self.operands.all? { |operand| operand.is_a? Numeric }
    end

    def operand_representations
      self.operands.collect do |operand|
        enclose = false
        enclose = true if operand.is_a? Expression

        if operands.is_a? Numeric
          enclose = true if operand < 0
        end

        representation = operand.to_s

        enclose ? '(' + representation + ')' : representation
      end
    end

    def infix
      self.operand_representations.join(' ' + self.operator + ' ')
    end

    def to_s
      self.infix
    end
  end

  class Sum < Expression
    def initialize(operands)
      @operation = :sum
      @operator = '+'
      @numeric_operator = :+
      @operands = operands
    end
  end

  class Subtraction < Expression
    def initialize(operands)
      @operation = :subtraction
      @operator = '-'
      @numeric_operator = :-
      @operands = operands
    end
  end

  class Multiplication < Expression
    def initialize(operands)
      @operation = :multiplication
      @operator = '-'
      @numeric_operator = :*
      @operands = operands
    end
  end

  class Division < Expression
    def initialize(operands)
      @operation = :multiplication
      @operator = '-'
      @numeric_operator = :/
      @operands = operands
    end
  end

  class Exponentiation < Expression
    def initialize(base, exponent)
      @operation = :exponentiation
      @operator = '^'
      @numeric_operator = :**
      @operands = [base, exponent]
    end

    def base
      @operands[0]
    end

    def exponent
      @operands[1]
    end

    def evaluate
      evaluated = Exponentiation.new(*self.evaluate_operands)
      evaluated.numeric_operands? ? evaluated.base ** evaluated.exponent : evaluated
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
