#! /usr/bin/env ruby

def compare(left, right)
	left.each_with_index do |l, i|
		# check for mismatch + convert
		# compare arrays
		compare(l, right[i])
		# compare integers
	end
end

pairs = [[]]
File.open("test.txt").each do |line|
	line.strip!
	if line== ""
		pairs << []
	else
		eval("pairs.last << #{line}")
	end
end

in_order = []
pairs.each_with_index do |pair, index|
	left = pair.first
	right = pair.last
	in_order << index if compare(left, right) 
end
