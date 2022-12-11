#! /usr/bin/env ruby

class Monkey
	attr_accessor :inpection_count
	def initialize(operation, test_case, true_monkey, false_monkey)
		@operation = operation
		@test_case = test_case
		@inpection_count = 0
		@true_monkey = true_monkey
		@false_monkey = false_monkey
	end

	# inspect an item and return the item val + target monkey
	def inspection(item)
		@inpection_count += 1
		new = 0

		# remove eval
		parts = @operation.match(/= .* (.) (.*)/)
		new = if parts[1] == "*"
			if parts[2] == "old"
				item * item
			else
				item * parts[2].to_i
			end
		else
			item + parts[2].to_i
		end
		new /= 3

		[new, new % @test_case == 0 ? @true_monkey : @false_monkey]
	end
end
	
temp_monkey = []
monkey_array = []
File.open("test.txt").each do |line|
	if matches = line.match(/Monkey (\d)/)
		temp_monkey << { monkey: nil, items: nil, op: nil, test_case: nil, true_monkey: nil, false_monkey: nil }
	elsif matches = line.match(/Starting items: (.*)/)
		temp_monkey.last[:items] = matches[1].split(' ')
	elsif matches = line.match(/Operation: (.*)/)
		temp_monkey.last[:op] = matches[1]
	elsif matches = line.match(/Test: divisible by (.*)/)
		temp_monkey.last[:test_case] = matches[1]
	elsif matches = line.match(/If true: throw to monkey (\d)/)
		temp_monkey.last[:true_monkey] = matches[1]
	elsif matches = line.match(/If false: throw to monkey (\d)/)
		temp_monkey.last[:false_monkey] = matches[1]
		monkey_array << {monkey: Monkey.new(
			temp_monkey.last[:op],
			temp_monkey.last[:test_case].to_i,
			temp_monkey.last[:true_monkey].to_i,
			temp_monkey.last[:false_monkey].to_i
		), items: temp_monkey.last[:items]}
	end
end
# monkey_array.each {|m| puts m.inspect }
20.times do |i|
	puts i if i % 100 == 0
	monkey_array.each do |monkey|
		monkey[:items].each do |item|
			res = monkey[:monkey].inspection(item.to_i)
			monkey_array[res.last][:items] << res.first
		end
		monkey[:items] = [] # clear after looking
	end
end

puts monkey_array.collect {|m| m[:monkey].inpection_count}.sort.reverse[0..1].inject(:*)
