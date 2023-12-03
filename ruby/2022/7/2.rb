#! /usr/bin/env ruby

class Node
	attr_accessor :nodes, :parent, :type, :size, :name
	def initialize(type, name, size = nil, parent = nil)
		@type = type
		@name = name
		@size = size.to_i
		@my_size = 0
		@nodes = []
		@parent = parent
	end

	def up
		parent
	end

	def add_node(node)
		nodes << node
		@my_size += node.size if node.file? 
	end

	def file?
		type == :file
	end

	def directory?
		type == :dir
	end

	def directories
		nodes.collect {|node| node if node.directory? }.compact
	end

	def calculate_size	
		@my_size + (directories.any? ? directories.reduce(0) { |sum, d| sum + d.calculate_size } : 0 )
	end

	def root
		parent.nil? ? self : parent.root;
	end

	def all_directories
		(directories + directories.collect {|d| d.all_directories }).flatten.compact
	end
end

path = []
current = nil
File.open("full.txt").each do |line|
	if matched = line.match(/^\$ (.*) (.*)?/)
		if matched[1] == 'ls'
			next
		elsif matched[2] == '..' # cd up
			current = current.parent
		else # cd into dir
			if current
				current.add_node Node.new(:dir, matched[2], nil, current)
				current = current.nodes.last
			else # root dir
				current = Node.new(:dir, matched[2])
			end
		end
	elsif matched = line.match(/^(\d+) (.*)$/) # find files
		current.add_node(Node.new(:file, matched[2], matched[1], current))
	end
end

# walk the directories, keeping all less than 100_000
space_free = 70000000 - current.root.calculate_size
space_needed = 30000000
target = space_needed - space_free

delete = nil
current.root.all_directories.each do |e|
  delete = e if e.calculate_size >= target && (delete.nil? || e.calculate_size < delete.calculate_size)
end

puts delete.name
puts delete.calculate_size
