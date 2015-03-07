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