local aoc = require "lib.aoc"

local input = aoc.input.getInput()

local function answer1()
	local result = 0
	for _, char in aoc.string.iterate(input) do
		if char == "(" then
			result = result + 1
		elseif char == ")" then
			result = result - 1
		end
	end
	return result
end

local function answer2()
	local floor = 0
	for index, char in aoc.string.iterate(input) do
		if char == "(" then
			floor = floor + 1
		elseif char == ")" then
			floor = floor - 1
		end
		if floor == -1 then
			return index
		end
	end
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
