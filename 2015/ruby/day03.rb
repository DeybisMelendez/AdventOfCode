INPUT = File.open("day03.txt","r")
Vector = Struct.new(:x, :y) do
	def +(other)
		Vector.new(self.x + other.x, self.y + other.y)
	end
end

def answer1(input)
	result = 1
	position = Vector.new(0,0)
	path = [position]
	input.each_char do |char|
		case char
			when "^"
				position += Vector.new(0,-1)
			when ">"
				position += Vector.new(1,0)
			when "v"
				position += Vector.new(0,1)
			when "<"
				position += Vector.new(-1,0)
		end
		result += 1 if not path.include?(position)
		path << position
	end
	result
end

def answer2(input)
	result = 1
	santaPos = Vector.new(0,0)
	robotPos = Vector.new(0,0)
	path = [santaPos]
	santaTurn = true
	input.each_char do |char|
		if santaTurn
			case char
				when "^"
					santaPos += Vector.new(0,-1)
				when ">"
					santaPos += Vector.new(1,0)
				when "v"
					santaPos += Vector.new(0,1)
				when "<"
					santaPos += Vector.new(-1,0)
			end
			result += 1 if not path.include?(santaPos)
			path << santaPos
		else
			case char
				when "^"
					robotPos += Vector.new(0,-1)
				when ">"
					robotPos += Vector.new(1,0)
				when "v"
					robotPos += Vector.new(0,1)
				when "<"
					robotPos += Vector.new(-1,0)
			end
			result += 1 if not path.include?(robotPos)
			path << robotPos
		end
		santaTurn = !santaTurn
	end
	result
end
# imprimir por separado
puts "the answer 1 is " + answer1(INPUT).to_s
puts "the answer 2 is " + answer2(INPUT).to_s