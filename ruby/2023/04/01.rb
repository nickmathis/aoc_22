tickets = {}
points = 0
File.open("full.txt").each do |line|
  g, data = line.split(":")
  ticket = g.split(" ").last.to_i

  tickets[ticket] = {}
  mine, winners = data.split("|")
  mine = mine.split(" ").collect(&:to_i)
  winners = winners.split(" ").collect(&:to_i)
  
  points += 2**((mine & winners).size-1) if (mine & winners).size > 0
end

puts points
