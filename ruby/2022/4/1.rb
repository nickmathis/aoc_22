#! /usr/bin/env ruby
score = 0

File.open("full.txt").each do |line|
	parts = line.split(',')
	parts[0] = eval("(" + parts[0].gsub('-','..') + ").to_a")
	parts[1] = eval("(" + parts[1].gsub('-','..') + ").to_a")
	
	score += 1 if parts.include?(parts[0] & parts[1])
end

puts score
