#! /usr/bin/env ruby
TEST_GRID_SIZE = [[-11, 15], [14, -5]].freeze
class Pair
	attr_accessor :x, :y, :seen, :label
	def initialize(x, y, label = nil)
		@x = x
		@y = y
		@label = label
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

def move(rope, vector, steps)
	# move tail
	head = rope.first

	steps.times do
		# move head
		case vector
			when 'L'
				head.move(head.x - 1, head.y)
			when 'R'
				head.move(head.x + 1, head.y)
			when 'D'
				head.move(head.x, head.y - 1)
			when 'U'
				head.move(head.x, head.y + 1)
		end
		
		# move rest of rope
		rope.each_with_index do |knot, i|
			next if i == 0

			prev = rope[i - 1]
			tail = knot

			target_x = tail.x
			target_y = tail.y
			moving = false
			# check if tail needs moving
			if (prev.x - tail.x).abs == 2 && (prev.y - tail.y).abs == 2
				moving = true
				target_x = (tail.x + prev.x)/2
				target_y = (prev.y + tail.y)/2
			elsif (prev.x - tail.x).abs == 2
				moving = true
				target_x = (tail.x + prev.x)/2
				target_y = prev.y
			elsif (prev.y - tail.y).abs == 2
				moving = true
				target_x = prev.x
				target_y = (prev.y + tail.y)/2
			end

			if moving
				# puts "#{tail.label} from #{tail.x}, #{tail.y} to #{target_x}, #{target_y}"
				tail.move(target_x, target_y)
			else
				# puts "#{tail.label} stay" 
			end
	
		end
  	print(rope, "#{vector} #{steps}", 2, TEST_GRID_SIZE)

	end
	# puts rope.collect	{|i| "(#{i.x}, #{i.y})" }.inspect
end

def print(r, move_label, overrun = 2, force_grid = nil)
	return false
	puts "Move: #{move_label}"
	rope = r.dup

	x_min = 0; x_max = 0; y_min = 0; y_max = 0;

	if force_grid
		# format: [[x,y], [x,y]]

		# top-left
		x_min = force_grid.first.first;
		y_max = force_grid.first.last;

		# bottom right
		x_max = force_grid.last.first;
		y_min = force_grid.last.last;
	end	

	# prevent overrun if grid is too small
	rope << Pair.new(0, 0, "s")
	rope.each do |k|
		x_min = k.x if k.x < x_min
		x_max = k.x if k.x > x_max
		y_min = k.y if k.y < y_min
		y_max = k.y if k.y > y_max
	end
	# puts "(#{x_min}, #{y_min}) (#{x_max}, #{y_max})"
	x_vals = (x_min - overrun..x_max + overrun).to_a
	y_vals = (y_min - overrun..y_max + overrun).to_a.reverse

	# plot the grid from x_min to x_max, y_max - y_min rows 
	y_vals.each do |y|
		output = []
		x_vals.each do |x|
			# output << "(#{x}, #{y})"
			# output << ""
			# put the actual indicator in the output array
			# defaults to '.'
			val = '.'
			# puts "x: #{x}, y: #{y}"
			rope.each do |r|
				# puts "--- #{r.label}: #{r.x}, #{r.y}"
			  if r.x == x && r.y == y
			  	val = r.label 
			  	break
			  end
			end

			output << val
		end
		puts output.join ''
	end
	puts ' '
end

rope = []
rope << Pair.new(0, 0, "H")
9.times { |i| rope << Pair.new(0, 0, i + 1) }

File.open("full.txt").each do |line|
	matches = line.match(/(.) (\d+)/)
	move(rope, matches[1], matches[2].to_i)
	print(rope, "#{matches[1]} #{matches[2]}", 0, TEST_GRID_SIZE)
end

puts rope.last.seen.count
