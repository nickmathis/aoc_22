#! /usr/bin/env ruby
score = 0
group = []

File.open("full.txt").each_with_index do |line, index|
	group << line.strip.split('') 
	if index % 3 == 2
		dupe = (group[0] & group[1] & group[2]).first
		score +=  dupe.ord > 96 ? dupe.ord - 96 : dupe.ord - 38
		group = []
	end
end

puts score
