schematic = []
File.open("full.txt").each do |line|
  schematic << line.strip.split('')
end

numbers = {}
current_number = ""
regex = '*'
location = nil
res = 0

schematic.each_with_index do |row, i|
  row.each_with_index do |num, j|
    if num =~ /\d/
      current_number << num
      begin
        location = "#{i - 1}-#{j - 1}" if schematic[i - 1][j - 1] == regex # NW
        location = "#{i - 1}-#{j}"     if schematic[i - 1][j]     == regex # N
        location = "#{i - 1}-#{j + 1}" if schematic[i - 1][j + 1] == regex # NE
        location = "#{i}-#{j - 1}"     if schematic[i][j - 1]     == regex # W
        location = "#{i}-#{j + 1}"     if schematic[i][j + 1]     == regex # E
        location = "#{i + 1}-#{j - 1}" if schematic[i + 1][j - 1] == regex # SW
        location = "#{i + 1}-#{j}"     if schematic[i + 1][j]     == regex # S
        location = "#{i + 1}-#{j + 1}" if schematic[i + 1][j + 1] == regex # SE
      rescue # ignore array overrun for simplicity
        nil
      end
    elsif current_number != ""
      puts "res = #{current_number}: #{location}"
      if numbers[location] && location
        res += numbers[location] * current_number.to_i
      elsif location
        numbers[location] = current_number.to_i # store first
      end

      # reset 
      location = nil
      current_number = ""
    end
  end
end

puts res
