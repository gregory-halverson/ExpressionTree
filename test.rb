require_relative 'expressiontree.rb'

include ExpressionTree

s = sum(1, mul(div(4, sub(3, 1)), 4))

puts s
puts s.evaluate
