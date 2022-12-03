#! /usr/bin/env ruby
score = 0

File.open("full.txt").each do |line|
	dupe = (line[0..line.size/2 - 1].split('')  & line[line.size/2..line.size].split('')).first
	score +=  dupe.ord > 96 ? dupe.ord - 96 : dupe.ord - 38
end

puts score
