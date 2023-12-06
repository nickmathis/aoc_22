test = false

races = if test 
  [[71530, 940200]] # test
else
  [[35937366, 212206012011044]] # full
end

answer = 1

races.each do |race|
  winning_count = 0
  time, dist = *race
  time.times do |iteration|
    i = iteration + 1
    # i = time wait = speed
    # distance ran = time - i
    # winning = distance ran > dist
    winning_count += 1 if (time - i) * i > dist
  end
  answer *= winning_count
end

puts answer
