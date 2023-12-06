tickets = {}
ticket_count = 0
File.open("full.txt").each do |line|
  # ticket_count += 1
  g, data = line.split(":")
  ticket = g.split(" ").last.to_i

  tickets[ticket] ||= 0
  tickets[ticket] += 1
  mine, winners = data.split("|")
  mine = mine.split(" ").collect(&:to_i)
  winners = winners.split(" ").collect(&:to_i)
  
  (mine & winners).size.times do |i|
    tickets[ticket + i + 1] ||= 0
    tickets[ticket + i + 1] += tickets[ticket]
  end
end

puts tickets.inspect

tickets.collect{|i| ticket_count += i.last}
puts ticket_count
