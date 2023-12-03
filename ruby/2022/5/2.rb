#! /usr/bin/env ruby

def move(stacks, qty, from, to)
	puts "Move #{qty} from: (#{from}) " + stacks[from].inspect + " to: (#{to}) " + stacks[to].inspect
	moving = stacks[from].pop(qty)
	moving.each {|e| stacks[to] << e }
	
	stacks
end

stacks = []
stack_count = 0

lines = File.open("full.txt").to_a

# get the stack count
lines.each do |line|
	next unless line .match(/^ 1/)
	stack_count = line.split(' ').max.to_i
	break
end

# load stacks
lines.each_with_index do |line, line_num|
	break if line .match(/^ 1/)
	stacks << []
	stack_count.times {|i| stacks[line_num] << line[4*i - 3]}
end

# courtesy https://stackoverflow.com/questions/22618894/how-do-i-rotate-this-2-d-array-using-ruby
stacks = stacks.transpose.map(&:reverse).rotate
stacks.each_with_index {|stack, i| stacks[i].reject! {|e| e == " "}}

puts stacks.inspect 

# load stacks
lines.each_with_index do |line, line_num|
	if matches = line .match(/^move (\d+) from (\d+) to (\d+)/)
		stacks = move(stacks, matches[1].to_i, matches[2].to_i - 1, matches[3].to_i - 1)
	end
end
puts stacks.inspect
puts stacks.collect{|e| e.last}.join
