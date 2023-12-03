#! /usr/bin/env ruby
total = 0 

File.open("full.txt").each do |line|
  line.split('').collect { |i|  i if i =~ /\d/ }.compact.tap{|elem| total += (elem.first + elem.last).to_i }
end

puts total
