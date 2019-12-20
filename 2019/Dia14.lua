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

local lines = split(text, "\n")
local list = {}
for l, line in ipairs(lines) do
	local letters = split(line, ", =>")
	local recipe = {}
	for i=1, #letters, 2 do
		if i < #letters-2 then
			print(l, letters[i], letters[i+1])
			table.insert(recipe, {tonumber(letters[i]), letters[i+1]})
		else break
		end
	end
	print("quant", letters[#letters-1], "recipe", letters[#letters])
	recipe["quant"] = letters[#letters-1]
	list[letters[#letters]] = recipe
end
local sobrantes = {}
local function getOre(quant, material)
	print(quant, material)
	local total = 0
	--for _=1, quant do
		for i, v in pairs(list[material]) do
		--print(i, v[2])
			local nquant, newMaterial = v[1], v[2]
			--print(material, quant, newMaterial)
			if newMaterial == "ORE" then
				total = total + math.ceil(quant/list[material]["quant"])*nquant
			elseif not(i == "quant") then			
				local sobrante = sobrantes[material] or 0
				if sobrante >= quant then
					sobrantes[newMaterial] = sobrantes[newMaterial] - nquant
					print(sobrantes[newMaterial])
				else
					local repeats = math.ceil(nquant/list[newMaterial]["quant"])
					if sobrantes[newMaterial] then
						sobrantes[newMaterial] = sobrantes[newMaterial] + nquant - list[newMaterial]["quant"]
					else
						sobrantes[newMaterial] = nquant - list[newMaterial]["quant"]
					end
					total = total + getOre(repeats, newMaterial)
				end
			end
		end
	--end
	return total
end
print("the answer 1 is", getOre(1, "BC"))
print("A", sobrantes["A"],"B", sobrantes["B"],"C", sobrantes["C"])