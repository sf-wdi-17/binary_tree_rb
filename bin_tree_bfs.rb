module BreadthFirstSearch

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
			while(@input.next.next)
				current = @input
			end

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

end