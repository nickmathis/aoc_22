#! /usr/bin/env ruby
score = 0

File.open("full.txt").each do |line|
	parts = line.split(',')
	parts[0] = eval("(" + parts[0].gsub('-','..') + ").to_a")
	parts[1] = eval("(" + parts[1].gsub('-','..') + ").to_a")
	
	score += 1 if parts[0].first >= parts[1].first && parts[0].first <= parts[1].last || parts[1].first >= parts[0].first && parts[1].first <= parts[0].last
end

puts score
