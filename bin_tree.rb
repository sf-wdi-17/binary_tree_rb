require_relative './bin_tree_bfs.rb'

module FixNumMax
	def maximum(x, y)
		return x < y ? y : x
	end
end

class BinTree
	include BinTreeBreadthFirstSearchHelpers, FixNumMax
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
			current_node = q.dequeue
			bin_tree = current_node.bin_tree

			if bin_tree.value != nil and bin_tree.value == v
				return true
			else
				# value not found in first current_node pulled from q 
				if bin_tree.left != nil
					left = bin_tree.left
										q.enqueue(left) # queue up left node
									else
									end

									if bin_tree.right != nil
										right = bin_tree.right
										q.enqueue(right)
									else
									end
								end
							end

		# if we're here, the queue is now empty and the search has therefore failed to find the value we wanted
		return false
	end

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

