local aoc = require "lib.aoc"
local input = aoc.string.split(aoc.input.getInput("input.txt"), "\n")

local function answer1()
	local result = 0
	for _, line in ipairs(input) do
		local dim = aoc.string.split(line, "x") -- L, W, H
		local minArea = 100000000
		for i = 1, #dim - 1 do
			for i2 = i + 1, #dim do
				local newMin = dim[i] * dim[i2]
				if minArea > newMin then
					minArea = newMin
				end
			end
		end
		result = result + (2 * dim[1] * dim[2]) + (2 * dim[3] * dim[2]) + (2 * dim[3] * dim[1]) + minArea
	end
	return result
end

local function answer2()
	local result = 0
	for _, line in ipairs(input) do
		local dim = aoc.string.split(line, "x") -- L, W, H
		dim[1], dim[2], dim[3] = tonumber(dim[1]), tonumber(dim[2]), tonumber(dim[3])
		table.sort(dim, function(a, b) return a < b end)
		result = result + (dim[1] * 2) + (dim[2] * 2) + (dim[1] * dim[2] * dim[3])
	end
	return result
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
