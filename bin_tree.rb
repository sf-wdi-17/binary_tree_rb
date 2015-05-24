require 'pry'
# require_relative './bin_tree_bfs.rb'

def maximum(x, y)
	return x < y ? y : x
end

class Node
	attr_reader :bin_tree
	attr_accessor :next
	def initialize(bin_tree)
		@bin_tree = bin_tree # custom nodes for holding binary tree nodes.
		@next = nil
	end
end

class Queue
	attr_reader :size

	def initialize 
		@input = @output = nil
		@size = 0
	end

	def enqueue(bin_tree)
		node = Node.new(bin_tree)
		# Special case: queue is empty
		if @size == 0
			@input = @output = node
			@size += 1 and return # Increment size and then exit
		end

		node.next = @input
		@input = node
		@size += 1
	end

	def dequeue
		if self.empty?
			p "is empty"
			return nil # if queue empty, we can't dequeue anything
		end

		# special case, only 1 node left
		if @size == 1
			p "1 left"
			node = @output
			@input = @output = nil
			@size = 0 # set @size to 0 now
			return node
		end

		# Queue won't be emptied by this dequeue op, so proceed
		current = @input
		p "@input = #{@input.to_s} and current = #{current.to_s}"
		p "also @input.next.next = #{@input.next.next}"
		while(current.next.next != nil)
			p "starting traversal of queue, current = #{current.to_s}"
			current = current.next
		end

		p "exited traversal, current.next = #{current.next.to_s}"
		node = current.next
		current.next = nil
		@output = current
		@size -= 1

		return node
	end

	def peek
		unless self.empty?
			return @output
		end

		# If the queue is empty, we'll end up here, so return nil
		return nil
	end

	def empty?
		if @size == 0
			return true
		end

		return false
	end
end
class BinTree
	attr_accessor :value
	attr_reader :left, :right

	# @height = 0 # start at 0
	# class << self; attr_accessor :height; end;

	def initialize(value=nil)
		@value = value
		@left = nil
		@right = nil
	end

	def insert(v)
		if v == @value
			return; #return if v already in tree
		end

		if v < @value
			insert_left(v)
		else
			insert_right(v)
		end

		self		
	end

	def height
		lh = 0
		if @left != nil
			lh = @left.height			
		end

		rh = 0
		if @right != nil
			rh = @right.height
		end

		return 1 + maximum(lh, rh)
	end

	def include?(v)
		if @value == v
			return true
		elsif v < @value and @left
			return @left.include?(v)
		elsif v > @value and @right
			return @right.include?(v)
		end

		return false # if we're here the value was not found
	end

	def bfs(v)

		q = Queue.new
		q.enqueue(self)

		while(!q.empty?)
			p "starting another loop top"
			p "Current queue size is #{q.size.to_s}"
			current_node = q.dequeue
			bin_tree = current_node.bin_tree

			p "starting another loop"
			p "bin_tree is now: #{bin_tree.to_s}"
			if bin_tree.value != nil and bin_tree.value == v
				p "value found, returning true"
				return true
			else
				# value not found in first current_node pulled from q 
				if bin_tree.left != nil
					left = bin_tree.left
					p "there is a left = #{left.to_s}"
					q.enqueue(left) # queue up left node
				else
					p "left is nil"
				end

				if bin_tree.right != nil
					right = bin_tree.right
					p "there is a right = #{right.to_s}"
					q.enqueue(right)
				else
					p "right is nil"
				end
			end
		end

		# if we're here, the queue is now empty and the search has therefore failed to find the value we wanted
		return false
	end

=begin
	BFS starts with an empty queue
	then enqueue's the head of the bin tree
	then starts a loop
	then for each loop, sets current node to the head of the queue
	then checks to see if that BinTree's value matches, if it does, we exit
	if not, we
		check that BT's left link - if exists, left is added to queue for next loop
		same for right
	then we start the loop again
	
=end

	private

	def insert_left(v)
		if self.left
			self.left.insert(v)
		else
			@left = BinTree.new(v)
		end
	end

	def insert_right(v)
		if self.right
			self.right.insert(v)
		else
			@right = BinTree.new(v)
		end
	end


end

a = [100, 102, 85, 67, 99, 61, 32, 4, 18]
puts a.to_s

bt = BinTree.new
bt.value = a.shift

a.size.times { bt.insert a.shift }

binding.pry