#! /usr/bin/env ruby

elves = [0]
File.open("full.txt").each do |line|
	elves[elves.size-1] += line.to_i
	
	elves << 0 if line == "\n"
end

puts elves.max # first part 
puts elves.sort[-3, 3].inject(:+) # second part
