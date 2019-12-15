local function newPlanet(x, y, z)
	return {pos = {x = x, y = y, z = z}, speed = {x = 0, y = 0, z = 0}}
end
local planets = {}
planets[1] = newPlanet(-1,0,2)--(-2,9,-5) +1 +1 +1
planets[2] = newPlanet(2,-10,-7)--(16,19,9)
planets[3] = newPlanet(4,-8,8)--(0,3,6)
planets[4] = newPlanet(3,5,-1)--(11,0,11)

local function calcGrav(value1, value2)
	local x1, y1, z1 = 0, 0, 0
	if value2.pos.x > value1.pos.x then x1 = 1 elseif value2.pos.x < value1.pos.x then x1 = -1 end
	if value2.pos.y > value1.pos.y then y1 = 1 elseif value2.pos.y < value1.pos.y then y1 = -1 end
	if value2.pos.z > value1.pos.z then z1 = 1 elseif value2.pos.z < value1.pos.z then z1 = -1 end
	print(x1,y1,z1)
	return x1, y1, z1
end

for step=1, 10 do
	
	--print(value1.pos.x, value1.pos.y, value1.pos.z, "speed ", planets[p1].speed.x, planets[p1].speed.y, planets[p1].speed.z)
	-- Aplicamos gravedad
	local x, y, z = calcGrav(planets[1],planets[2])
	planets[1].pos.x, planets[1].pos.y, planets[1].pos.z = planets[1].pos.x + x, planets[1].pos.y + y, planets[1].pos.z + z
	x, y, z = calcGrav(planets[1],planets[3])
	planets[1].pos.x, planets[1].pos.y, planets[1].pos.z = planets[1].pos.x + x, planets[1].pos.y + y, planets[1].pos.z + z
	x, y, z = calcGrav(planets[1],planets[4])
	planets[1].pos.x, planets[1].pos.y, planets[1].pos.z = planets[1].pos.x + x, planets[1].pos.y + y, planets[1].pos.z + z
	
	x, y, z = calcGrav(planets[2],planets[1])
	planets[2].pos.x, planets[2].pos.y, planets[2].pos.z = planets[2].pos.x + x, planets[2].pos.y + y, planets[2].pos.z + z
	x, y, z = calcGrav(planets[2],planets[3])
	planets[2].pos.x, planets[2].pos.y, planets[2].pos.z = planets[2].pos.x + x, planets[2].pos.y + y, planets[2].pos.z + z
	x, y, z = calcGrav(planets[2],planets[4])
	planets[2].pos.x, planets[2].pos.y, planets[2].pos.z = planets[2].pos.x + x, planets[2].pos.y + y, planets[2].pos.z + z
	
	x, y, z = calcGrav(planets[3],planets[1])
	planets[3].pos.x, planets[3].pos.y, planets[3].pos.z = planets[3].pos.x + x, planets[3].pos.y + y, planets[3].pos.z + z
	x, y, z = calcGrav(planets[3],planets[2])
	planets[3].pos.x, planets[3].pos.y, planets[3].pos.z = planets[3].pos.x + x, planets[3].pos.y + y, planets[3].pos.z + z
	x, y, z = calcGrav(planets[3],planets[4])
	planets[3].pos.x, planets[3].pos.y, planets[3].pos.z = planets[3].pos.x + x, planets[3].pos.y + y, planets[3].pos.z + z
	
	
	x, y, z = calcGrav(planets[4],planets[1])
	planets[4].pos.x, planets[4].pos.y, planets[4].pos.z = planets[4].pos.x + x, planets[4].pos.y + y, planets[4].pos.z + z
	x, y, z = calcGrav(planets[4],planets[2])
	planets[4].pos.x, planets[4].pos.y, planets[4].pos.z = planets[4].pos.x + x, planets[4].pos.y + y, planets[4].pos.z + z
	x, y, z = calcGrav(planets[4],planets[3])
	planets[4].pos.x, planets[4].pos.y, planets[4].pos.z = planets[4].pos.x + x, planets[4].pos.y + y, planets[4].pos.z + z
	--Aplicamos velocidad
	--print(step)
	for p1, value in ipairs(planets) do
		planets[p1].pos.x, planets[p1].pos.y, planets[p1].pos.z = planets[p1].pos.x + planets[p1].speed.x, planets[p1].pos.y + planets[p1].speed.y, planets[p1].pos.z + planets[p1].speed.z
	end

end
local potentialEnergy = 0
local KineticEnergy = 0
local result = 0
for planet, value in ipairs(planets) do
	local xp, yp, zp = math.abs(value.pos.x), math.abs(value.pos.y), math.abs(value.pos.z)
	local xk, yk, zk = math.abs(value.speed.x), math.abs(value.speed.y), math.abs(value.speed.z)
	result = result + ((xp+yp+zp)*(xk+yk+zk))
	print(xp, yp, zp, xk, yk, zk)
end

print("answer 1 is", result)