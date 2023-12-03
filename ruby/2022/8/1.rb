#! /usr/bin/env ruby

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
puts grovex.inspect
puts grovey.inspect

visible = 0
grovex.each_with_index do |row, y|
	row.each_with_index do |spot, x|
		if x == 0 || x == row.size - 1
			visible += 1 
		elsif y == 0 || y == grovex.size - 1
			visible += 1
		else
			puts "(#{x}, #{y})->#{spot}"
			puts row[0..x-1].inspect
			puts row[x+1..row.size-1].inspect
			if spot > row[0..x-1].max # left
				puts "(#{x}, #{y})->#{spot} VISIBLE"
				visible += 1
			elsif spot > row[x+1..row.size - 1].max # right
				puts "(#{x}, #{y})->#{spot} VISIBLE"
				visible += 1
			elsif spot > grovey[x][0..y-1].max # top
				puts "(#{x}, #{y})->#{spot} VISIBLE"
				visible += 1
			elsif spot > grovey[x][y+1..grovey[x].size - 1].max # bottom
				puts "(#{x}, #{y})->#{spot} VISIBLE"
				visible += 1
			end
			puts "\n\n"
		end
	end
end

puts visible
