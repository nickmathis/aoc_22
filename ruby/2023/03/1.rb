schematic = []
File.open("full.txt").each do |line|
  schematic << line.strip.split('')
end

numbers = []
current_number = ""
use = false
schematic.each_with_index do |row, i|
  row.each_with_index do |num, j|
    if num =~ /\d/
      current_number << num
      begin
      use = true if schematic[i - 1][j - 1] =~ /[^\d\.]/ # NW
      use = true if schematic[i - 1][j]     =~ /[^\d\.]/ # N
      use = true if schematic[i - 1][j + 1] =~ /[^\d\.]/ # NE
      use = true if schematic[i][j - 1]     =~ /[^\d\.]/ # W
      use = true if schematic[i][j + 1]     =~ /[^\d\.]/ # E
      use = true if schematic[i + 1][j - 1] =~ /[^\d\.]/ # SW
      use = true if schematic[i + 1][j]     =~ /[^\d\.]/ # S
      use = true if schematic[i + 1][j + 1] =~ /[^\d\.]/ # SE
      rescue # ignore array overrun for simplicity
        nil
      end
    elsif current_number != ""
      numbers << current_number.to_i if use
      # reset 
      use = false
      current_number = ""
    end
  end
end

puts numbers.inject(&:+)
