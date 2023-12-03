#! /usr/bin/env ruby

class Tree
	class Node
		def intiialize(parent, label, uid)
			@depth = parent.depth + 1
			@root = @parent.nil? ? true : false
			@uid = uid
			@label = label
			@nodes = []
		end

		def uid_path
			return uid if root?
			@parent.uid_path + '-' + uid
		end

		def path
			return uid if root?
			@parent.path + '-' + uid
		end

		def root?
			@root
		end

		# return node or false if not added
		def add_node(label, uid)
			node = Node.new(self, label, uid)
			unless uid_path.include?(uid)
				@nodes << node
				node
			else
				false
			end
		end
	end
end	

grid = []
s = []
File.open("test.txt").each_with_index do |line, i|
	parsed = line.strip.split('')
	grid << parsed
	if line.index('S')
		s = [line.index('S'), grid.size - 1]
	end
end
tree = Mode.new(nil, 'S', "#{s.first}-#{s.last}")
def loadTree(pos, grid)
end

puts grid.inspect
puts s.inspect
