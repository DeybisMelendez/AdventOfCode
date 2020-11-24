local file = io.open("day02input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local lines = split(text, "[^\n]+")

local function answer1()
	local result = 0
	for _, line in ipairs(lines) do
		local dim = split(line, "[^x]+") -- L, W, H
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

local function answer2()
	local result = 0
	for _, line in ipairs(lines) do
		local dim = split(line, "[^x]+") -- L, W, H
		dim[1], dim[2], dim[3] = tonumber(dim[1]), tonumber(dim[2]), tonumber(dim[3])
		table.sort(dim, function(a,b) return a < b end)
		result = result + (dim[1]*2) + (dim[2]*2) + (dim[1] * dim[2] * dim[3])
	end
	return result
end

print("the answer 1 is", answer1())
print("the answer 2 is", answer2())