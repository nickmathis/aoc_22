#! /usr/bin/env ruby
class Pair
	attr_accessor :x, :y, :seen
	def initialize(x, y)
		@x = x
		@y = y
		@seen = []
		log_position
	end

	def move(x, y)
		@x = x
		@y = y
		log_position
	end

	private
	def log_position
		@seen << [@x, @y] unless @seen.include?([@x, @y])
	end
end

def move(head, tail, vector, steps)
	# move tail
	steps.times do
		# move head
		case vector
			when 'D'
				head.move(head.x - 1, head.y)
			when 'U'
				head.move(head.x + 1, head.y)
			when 'L'
				head.move(head.x, head.y - 1)
			when 'R'
				head.move(head.x, head.y + 1)
		end
		
		# check if tail needs moving
		if (head.x - tail.x).abs == 2
			tail.move((tail.x + head.x)/2, head.y)
		elsif (head.y - tail.y).abs == 2
			tail.move(head.x, (head.y + tail.y)/2)
		end
	end
end

head = Pair.new(0, 0)
tail = Pair.new(0, 0)

File.open("full.txt").each do |line|
	matches = line.match(/(.) (\d+)/)
	move(head, tail, matches[1], matches[2].to_i)
end

puts tail.seen.count




H

1 H     # R

  H     # U
1

  1  H  # R
2
