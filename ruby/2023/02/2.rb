games = {}
File.open("full.txt").each do |line|
  g, data = line.split(":")
  game = g.split(" ").last.to_i

  games[game] = {}
  data.split(";").each do |move|
    move.split(", ").each do |blocks|
      num, color = blocks.split(" ")
      games[game][color] ||= 0
      games[game][color] = num.to_i if games[game][color] < num.to_i
    end
  end
end

puts games
result = 0
games.each do |i, data|
  result += data['red'] * data['green'] * data['blue']
end

puts result
