local input = {
	{pos ={x=-2, y=9, z=-5}, speed = {x=0,y=0,z=0}},
	{pos = {x=16, y=19, z=9}, speed = {x=0,y=0,z=0}},
	{pos ={x=0, y=3, z=6}, speed = {x=0,y=0,z=0}},
	{pos ={x=11, y=0, z=11}, speed = {x=0,y=0,z=0}}

--	{pos = {x=-1, y=0, z=2}, speed = {x=0,y=0,z=0}},
--	{pos = {x=2, y=-10, z=-7}, speed = {x=0,y=0,z=0}},
--	{pos ={x=4, y=-8, z=8}, speed = {x=0,y=0,z=0}},
--	{pos ={x=3, y=5, z=-1}, speed = {x=0,y=0,z=0}}
	
--	{pos = {x=-8, y=-10, z=0}, speed = {x=0,y=0,z=0}},
--	{pos = {x=5, y=5, z=10}, speed = {x=0,y=0,z=0}},
--	{pos ={x=2, y=-7, z=3}, speed = {x=0,y=0,z=0}},
--	{pos ={x=9, y=-8, z=-3}, speed = {x=0,y=0,z=0}}

}
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
local function getNewSpeed(a, b)
	local x, y, z = 0, 0, 0 -- gravedad
	if b.pos.x > a.pos.x then x = 1 elseif b.pos.x < a.pos.x then x = -1 end
	if b.pos.y > a.pos.y then y = 1 elseif b.pos.y < a.pos.y then y = -1 end
	if b.pos.z > a.pos.z then z = 1 elseif b.pos.z < a.pos.z then z = -1 end
	return {x = x + a.speed.x, y = y + a.speed.y, z = z + a.speed.z}
end

local function getNewPos(a)
	return {x = a.pos.x + a.speed.x, y = a.pos.y + a.speed.y, z = a.pos.z + a.speed.z}
end

local function getEnergy(p)
	local abs = math.abs
	local potential = abs(p.pos.x) + abs(p.pos.y) + abs(p.pos.z)
	local kinetic = abs(p.speed.x) + abs(p.speed.y) + abs(p.speed.z)
	return potential * kinetic
end

local function answer1()
	local planets = deepcopy(input)
	local totalEnergy = 0
	for step=1, 1000 do
		for i1, v1 in ipairs(planets) do
			-- aplicamos la gravedad
			for i2, v2 in ipairs(planets) do
				v1.speed = getNewSpeed(v1, v2)
			end
		end
		for _, v in ipairs(planets) do
			-- aplicamos velocidad
			v.pos = getNewPos(v)
			--print(step, v1.pos.x, v1.pos.y, v1.pos.z, v1.speed.x, v1.speed.y, v1.speed.z)
		end
	end
	for _, v in ipairs(planets) do
		totalEnergy = totalEnergy + getEnergy(v)
	end
	return totalEnergy
end

local function pos2str(pos, next)
	local str = ""
	for i, v in ipairs(pos) do
		--str = v.pos.x .. v.pos.y .. v.pos.z .. v.speed.x .. v.speed.y .. v.speed.z
		if next == "x" then str = str .. v.pos.x .. v.speed.x
		elseif next == "y" then str = str .. v.pos.y .. v.speed.y
		elseif next == "z" then str = str .. v.pos.z .. v.speed.z
		end
	end
	return str
end

local function gcd(a,b)
  if type(a) == "number" and type(b) == "number" and 
        a == math.floor(a) and b == math.floor(b) then
    if b == 0 then
      return a
    else
      return gcd(b, a % b) -- tail recursion
    end
  else
    error("Invalid argument to gcd (" .. tostring(a) .. "," .. 
          tostring(b) .. ")", 2)
  end
end

local function answer2()
	local planets = deepcopy(input)
	local history = {}
	local step = 0
	local next = "x"
	local x, y, z, xy
	local reset = false
	while true do
		for i1, v1 in ipairs(planets) do
			-- aplicamos la gravedad
			for i2, v2 in ipairs(planets) do
				v1.speed = getNewSpeed(v1, v2)
			end
		end
		for _, v in ipairs(planets) do
			-- aplicamos velocidad
			v.pos = getNewPos(v)
			--print(step, v1.pos.x, v1.pos.y, v1.pos.z, v1.speed.x, v1.speed.y, v1.speed.z)
		end
		local str = pos2str(planets, next)
		if history[str] then
			if next == "x" then
				next = "y"
				x = step
				reset = true
				print("x encontrado", step)
			elseif next == "y" then
				next = "z"
				y = step
				reset = true
				print("y encontrado", step)
			elseif next == "z" then
				z = step
				print("z encontrado", step)
				break
			end
		end
		history[str] = true
		step = step + 1
		if reset then step = 0 reset = false history = {} planets = deepcopy(input) end
		--if step == next then print(step) next = next + 100000 end
		--print(step)
	end
	local g = gcd(x, y)
	xy = x * y / g
	print("xy",xy, "gcd", g)
	g = gcd(xy, z)
	print("g", g)
	return tostring(("%.f"):format(xy * z /g))
end
--print("answer 1 is", answer1())
print("answer 2 is", answer2())
print(tostring(("%.f"):format(100000000000000000000000000000000000000000000000000000000000000000000)))