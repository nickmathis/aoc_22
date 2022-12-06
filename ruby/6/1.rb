#! /usr/bin/env ruby

chars = File.open("full.txt").to_a.first.split('')

set = []
chars_in = 0
chars.each_with_index do |char,i|
	set[i % 4] = char
	if i > 3
		if set.uniq.size == 4
			chars_in = i + 1
			break;
		end
	end
end

puts chars_in
