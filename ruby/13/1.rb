#! /usr/bin/env ruby

def compare(left, right)
	if left.is_a?(Array) && right.is_a?(Array) && left.size > right.size
		puts "Left side ran out of items"
		return false
	end

	res = true

	puts "#{left.inspect} vs #{right.inspect}"
	left.each_with_index do |l, i|
	  puts "#{__LINE__}: #{i} vs #{right[i]}"
		
		# check for mismatch + convert
		if l.is_a?(Array) && !right[i].is_a?(Array)
			puts "line: #{__LINE__}"
			res = compare(l.first, right[i])
			next if res
		elsif right[i].is_a?(Array) && !l.is_a?(Array)
			puts "line: #{__LINE__}"
			res = compare(l, right[i].first)
			next if res
		end
		return false if !res
			
		# compare arrays
		if l.is_a?(Array) && right[i].is_a?(Array) 
			puts "line: #{__LINE__}"
			res = compare(l, right[i])
			return false if !res
			next	
		end
		
		puts "line: #{__LINE__}"

		# compare integers

		if l > right[i]
			puts "line: #{__LINE__}"
			return false
		end
	end
	puts "line: #{__LINE__}: success"
	true
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
	res = compare(left, right) 
	puts "Comparing (#{index+1}) #{left.inspect} .vs  #{right.inspect}; result: #{res}"
	in_order << index + 1 if compare(left, right) 
end

puts in_order.inspect
