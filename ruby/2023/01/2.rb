#! /usr/bin/env ruby
total = 0 
match_options = {"on1e": "one", "tw2o": "two", "thre3e": "three",  "fou4r": "four",  "fiv5e": "five", "si6x": "six", "seve7n": "seven", "eigh8t": "eight",  "nin9e": "nine"}

File.open("full.txt").each do |line|
  puts line
  
  line.split('').each do |char|
    match_options.each do |index, match_option |
      if line.include?(match_option.to_s)
        line.gsub!(match_option, index.to_s)
      end
    end
  end
  puts "\t#{line}"
  
  line.split('').collect { |i|  i if i =~ /\d/ }.compact.tap{|elem| puts (elem.first + elem.last); total += (elem.first + elem.last).to_i }
end

puts total

# 54708
