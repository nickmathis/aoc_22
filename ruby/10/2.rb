#! /usr/bin/env ruby

class CPU
	attr_accessor :strength
	CYCLES = [20, 60, 100, 140, 180, 220].freeze
	
	def initialize
		@cycle = 1
		@x = 1
		@strength = 0
		@display = ['']
	end

	def advance(x = 0)		
		draw
		@x += x
		@cycle += 1
	end

	def draw
		pixel = (@cycle % 40) - 1
		# puts "cycle: #{@cycle}; pixel: #{pixel}, sprite: #{[@x - 1, @x, @x + 1].inspect}"

		@display << '' if pixel == 0
		if [@x - 1, @x, @x + 1].include?(pixel)
			@display.last << 'X' 
		else 
			@display.last << ' '
		end
	end

	def render
		@display.each do |line|
			puts line
		end
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

cpu.render

