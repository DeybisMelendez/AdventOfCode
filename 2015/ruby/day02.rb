$input = File.open("day02.txt", "r").readlines

def answer1()
	result = 0
	$input.each do |line|
		present = line.split("x").map(&:to_i)
		result += 2 * present[0] * present[1]
		result += 2 * present[1] * present[2]
		result += 2 * present[2] * present[0]
		present.sort!
		result += present[0] * present[1]
	end
	result
end

def answer2()
	result = 0
	$input.each do |line|
		present = line.split("x").map(&:to_i)
		present.sort!
		result += (present[0] + present[1]) * 2 + present.inject(:*)
	end
	result
end

puts "the answer 1 is " + answer1().to_s
puts "the answer 2 is " + answer2().to_s