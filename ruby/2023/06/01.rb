test = false

races = if test 
  [[7, 9], [15, 40], [30, 200]] # test
else
  [[35, 212], [93, 2060], [73, 1201], [66, 1044]] # full
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
