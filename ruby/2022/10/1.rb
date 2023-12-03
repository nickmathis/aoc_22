#! /usr/bin/env ruby

class CPU
	attr_accessor :strength
	CYCLES = [20, 60, 100, 140, 180, 220].freeze
	
	def initialize
		@cycle = 1
		@x = 1
		@strength = 0
	end

	def advance(x = 0)
		@strength += @x * @cycle if CYCLES.include?(@cycle)
		@x += x
		@cycle += 1
	end
end

cpu = CPU.new

File.open("full.txt").each do |line|
	matches = line.match(/(\w+) ?(.*)/)

	# if cycles.include?(cycle) || cycles.include?(cycle)
	# 	puts line
	# 	puts "x: #{x}; cycle: #{cycle}"
	# 	strength += x * (cycle)
	# 	puts "-- strength: #{strength}"
	# end

	cpu.advance
	if matches[1] == 'addx'
		x = matches[2].to_i
		cpu.advance(x)
	end
end

puts cpu.strength
