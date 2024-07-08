require "utils"

local input = utils.readFile("day01input.txt")

local function answer1(input)
	local result = 0
	for char in input:gmatch(".") do
		if char == "(" then
			result = result + 1
		elseif char == ")" then
			result = result - 1
		end
	end
	return result
end

local function answer2(input)
	local floor = 0
	local result = 0
	for char in input:gmatch(".") do
		result = result + 1
		if char == "(" then
			floor = floor + 1
		elseif char == ")" then
			floor = floor - 1
		end
		if floor == -1 then
			return result
		end
	end
end

print("answer 1 is", answer1(input))
print("answer 2 is", answer2(input))