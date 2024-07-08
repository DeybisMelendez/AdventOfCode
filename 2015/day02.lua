require "utils"
local input = utils.split(utils.readFile("day02input.txt"), "[^\n]+")

local function answer1(input)
	local result = 0
	for _, line in ipairs(input) do
		local dim = utils.split(line, "[^x]+") -- L, W, H
		local minArea
		for i, v in ipairs(dim) do
			for i2, v2 in ipairs(dim) do
				if not (i == i2) then
					if not minArea or minArea > v*v2 then
						minArea = v*v2
					end
				end
			end
		end
		result = result + (2 * dim[1] * dim[2]) + (2 * dim[3] * dim[2]) + (2 * dim[3] * dim[1]) + minArea
	end
	return result
end

local function answer2(input)
	local result = 0
	for _, line in ipairs(input) do
		local dim = utils.split(line, "[^x]+") -- L, W, H
		dim[1], dim[2], dim[3] = tonumber(dim[1]), tonumber(dim[2]), tonumber(dim[3])
		table.sort(dim, function(a,b) return a < b end)
		result = result + (dim[1]*2) + (dim[2]*2) + (dim[1] * dim[2] * dim[3])
	end
	return result
end

print("the answer 1 is", answer1(input))
print("the answer 2 is", answer2(input))