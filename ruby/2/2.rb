#! /usr/bin/env ruby
score = 0

# should have just made a map:
# outcomes = { 'A Y' => 6, 'A Z' => 0, 'A X' => 3 }

def result(opp, me)
	points = {'X' => 1, 'Y' => 2, 'Z' => 3}
	
  points[me] + case opp
  when 'A' # rock
    case me
    	when 'Y'
    	 	6
    	when 'Z'
    	 	0
    	when 'X' 
    	  3
    end
  when 'B' # paper
  	case me
  	  when 'Z'
  		  6
  	  when 'X'
  	  	0
  	  when 'Y'
  	    3
  	end
  when 'C'
  	case me
	  	when 'X'
	  		6
	  	when 'Y'
	  		0
	  	when 'Z'
	  		3
  	end
  end
end

File.open("full.txt").each do |line|
	played = line.split(' ')
	score += result(played.first, played.last)
end

puts score
