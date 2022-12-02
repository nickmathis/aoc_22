#! /usr/bin/env ruby
score = 0

def result(opp, me)	
  case opp
  when 'A' # rock
    case me
    	when 'X'
    	 	3
    	when 'Y'
    	 	4
    	when 'Z' 
    	  8
    end
  when 'B' # paper
  	case me
  	  when 'X'
  		  1
  	  when 'Y'
  	  	5
  	  when 'Z'
  	    9
  	end
  when 'C' # scissors
  	case me
	  	when 'X'
	  		2
	  	when 'Y'
	  		6
	  	when 'Z'
	  		7
  	end
  end
end

File.open("full.txt").each do |line|
	played = line.split(' ')
	score += result(played.first, played.last)
end

puts score
