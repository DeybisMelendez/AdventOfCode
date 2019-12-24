input = []
File.open("day02.txt").each{ |line|
	line = line.match /(?<l>\d+) (?<w>\d+) (?<h>\d+)/
	puts line[:l]
	input. << line
}

def answer1(input)
	result = 0
	input.each { |line|
		puts line
		#result += (2 * line[:l] * line[:w]) + (2 * line[:w] * line[:h]) + (2 * line[:h] * line[:l])
	}
	result
end

puts "the answer 1 is" + answer1(input)