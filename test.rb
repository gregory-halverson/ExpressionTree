require_relative 'expressiontree.rb'

include ExpressionTree

s = sum(mul(2, 3), 2)

puts s
puts s.evaluate
puts s.class