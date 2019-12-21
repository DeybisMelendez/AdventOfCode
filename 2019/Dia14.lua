local file = io.open("Dia14.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch("[^" .. del .. "]+") do
        table.insert(t, value)
    end
    return t
end

local inventory = {}

local function getList(adjust)
	local lines = split(text, "\n")
	local list = {}
	for l, line in ipairs(lines) do
		local letters = split(line, ", =>")
		local recipe = {}
		for i=1, #letters, 2 do
			if i < #letters-2 then
				if adjust then
					table.insert(recipe, {adjust*tonumber(letters[i]), letters[i+1]})
				else
					table.insert(recipe, {tonumber(letters[i]), letters[i+1]})
				end
			else break
			end
		end
		if adjust then
			recipe["quant"] = adjust*letters[#letters-1]
		else
			recipe["quant"] = letters[#letters-1]
		end
		list[letters[#letters]] = recipe
	end
	return list
end

local function getOre(quant, material, list)
	local total = 0
	for i, v in pairs(list[material]) do
		local needs, newMaterial = v[1], v[2]
		if newMaterial == "ORE" then
			total = total + needs * quant
		elseif not(i=="quant") then
			needs = needs * quant
			local invMaterial = inventory[newMaterial] or 0
			local toDo = math.ceil((needs-invMaterial)/list[newMaterial]["quant"])
			inventory[newMaterial] = toDo*list[newMaterial]["quant"] - needs + invMaterial
			total = total + getOre(toDo, newMaterial, list)
		end
	end
	return total
end

local function answer1()
	inventory = {}
	local list = getList()
	return getOre(1, "FUEL", list)
end

local function answer2()
	inventory = {}
	local ore = 1000000000000
	local match = 100000000
	local list = getList()
	local result = math.floor((ore/getOre(match, "FUEL", list)) * match, 2)
	return result
end

print("the answer 1 is", answer1())
print("the answer 2 is", answer2())