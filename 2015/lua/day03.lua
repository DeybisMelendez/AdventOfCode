local file = io.open("day03input.txt", "r")
local input = file:read("*a")
file:close()

local function answer1()
	local houses = {}
	local currentPos = {x = 0, y = 0}
	--table.insert(houses, {currentPos.x, currentPos.y})
	for char in input:gmatch(".") do
		local visited = false
		for i, v in pairs(houses) do
			if (v.x == currentPos.x) and (v.y == currentPos.y) then
				visited = true
			end
		end
		if not visited then
			table.insert(houses, {x = currentPos.x, y = currentPos.y})
		end
		if char == ">" then
			currentPos.x = currentPos.x + 1
		elseif char == "^" then
			currentPos.y = currentPos.y - 1
		elseif char == "<" then
			currentPos.x = currentPos.x - 1
		elseif char == "v" then
			currentPos.y = currentPos.y + 1
		end
	end
	return #houses
end
local function answer2()
	local houses = {{x = 0, y = 0}}
	local santaPos = {x = 0, y = 0}
	local robotPos = {x = 0, y = 0}
	local santaTurn = false
	--table.insert(houses, {currentPos.x, currentPos.y})
	for char in input:gmatch(".") do
		local visited = false
		santaTurn = not santaTurn
		if santaTurn then
			if char == ">" then
				santaPos.x = santaPos.x + 1
			elseif char == "^" then
				santaPos.y = santaPos.y - 1
			elseif char == "<" then
				santaPos.x = santaPos.x - 1
			elseif char == "v" then
				santaPos.y = santaPos.y + 1
			end
			for i, v in pairs(houses) do
				if (v.x == santaPos.x) and (v.y == santaPos.y) then
					visited = true
				end
			end
			if not visited then
				table.insert(houses, {x = santaPos.x, y = santaPos.y})
			end
		else
			if char == ">" then
				robotPos.x = robotPos.x + 1
			elseif char == "^" then
				robotPos.y = robotPos.y - 1
			elseif char == "<" then
				robotPos.x = robotPos.x - 1
			elseif char == "v" then
				robotPos.y = robotPos.y + 1
			end
			for i, v in pairs(houses) do
				if (v.x == robotPos.x) and (v.y == robotPos.y) then
					visited = true
				end
			end
			if not visited then
				table.insert(houses, {x = robotPos.x, y = robotPos.y})
			end
		end
	end
	return #houses
end
print("the answer 1 is", answer1())
print("the answer 2 is", answer2())