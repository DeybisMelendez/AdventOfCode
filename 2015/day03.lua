require "utils"
local input = utils.readFile("day03input.txt")

local function answer1(input)
	local visits = {}
	local santa = {x=0,y=0}
	local totalVisits = 1
	local key = santa.x .. "," .. santa.y
	visits[key] = true

	for char in input:gmatch(".") do
		if char == ">" then
			santa.x = santa.x + 1
		elseif char == "^" then
			santa.y = santa.y - 1
		elseif char == "<" then
			santa.x = santa.x - 1
		elseif char == "v" then
			santa.y = santa.y + 1
		end

		key = santa.x .. "," .. santa.y

		if visits[key] == nil then
			visits[key] = true
			totalVisits = totalVisits + 1
		end
	end
	return totalVisits
end

local function answer2(input)
	local visits = {}
	local santa = {x=0,y=0}
	local roboSanta = {x=0,y=0}
	local totalVisits = 1
	local key = santa.x .. "," .. santa.y
	local turn = true
	visits[key] = true

	for char in input:gmatch(".") do
		local whoToMove = turn and santa or roboSanta

		if char == ">" then
			whoToMove.x = whoToMove.x + 1
		elseif char == "^" then
			whoToMove.y = whoToMove.y - 1
		elseif char == "<" then
			whoToMove.x = whoToMove.x - 1
		elseif char == "v" then
			whoToMove.y = whoToMove.y + 1
		end

		key = whoToMove.x .. "," .. whoToMove.y

		if visits[key] == nil then
			visits[key] = true
			totalVisits = totalVisits + 1
		end

		turn = not turn
	end
	return totalVisits
end
print("the answer 1 is", answer1(input))
print("the answer 2 is", answer2(input))