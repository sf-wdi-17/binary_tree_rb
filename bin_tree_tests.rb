require 'pry'
require_relative './bin_tree.rb'

a = [100, 102, 85, 67, 99, 61, 32, 4, 18]
puts a.to_s

bt = BinTree.new
bt.value = a.shift
a.size.times { bt.insert a.shift }


p bt.include? 85 # depth first search => true
p bt.include? 1001 # dfs, => false

p bt.bfs 67 # => true
p bt.bfs 1 # => false

# Try your own tests by uncommenting the line below
# binding.pry 