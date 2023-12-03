#! /usr/bin/env ruby

def calculate_score(row, val, position = nil)
	index = row.index {|e| e >= val }
	res = index ? index + 1 : row.size
	# puts "#{res} = #{row.inspect} (#{val}) for #{position}"
	res
end

def print_grid(grid, label = false)
	puts "#{label}:" if label
	grid.each do |r|
		puts r.join ' '
	end
end

grovex = []
grovey = []

File.open("full.txt").each_with_index do |line, x|
	grovex[x] = []
	
	line.strip.split('').each_with_index do |char, y|
		grovey[y] ||= []
		grovex[x][y] = char.to_i
		grovey[y][x] = char.to_i
	end
end

# print_grid grovex, :grovex
# print_grid grovey, :grovey

visible = 0
max = 0
grovex.each_with_index do |row, y|
	row.each_with_index do |spot, x|
		# skip edges, since score is 0
		if x == 0 || x == row.size - 1
			next
		elsif y == 0 || y == grovex.size - 1
			next
		else
			puts "(#{x}, #{y})->#{spot}"
			# puts row[0..x-1].inspect
			# puts row[x+1..row.size-1].inspect

			# look left
			left = calculate_score(row[0..x-1].reverse, spot, :left) # left
			right = calculate_score(row[x+1..row.size - 1], spot, :right) # right
			up = calculate_score(grovey[x][0..y-1].reverse, spot, :up) # up
			down = calculate_score(grovey[x][y+1..grovey[x].size - 1], spot, :down) # down
			this_score = left * right * up * down
			max = this_score if this_score > max
		end
	end
end

puts max
