local file = io.open("Dia6.txt", "r") -- Se requiere un archivo Dia6.txt para ejecutar
local text = file:read("*a")
file:close()

-- Funciones
-- Funcion que divide una cadena de texto con un delimitador
local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local input = split(text, "[^\n]+")
local orbits = {}
for _, value in ipairs(input) do
    local char = 0
    while not (value:sub(char, char) == ")") do
        char = char + 1
    end
    local a, b = value:sub(1, char-1), value:sub(char+1,value:len())--value:sub(1, 3), value:sub(7,9)
    orbits[b] = a
end

local function getOrbDistance(a, b, withPath)
    local path = {}
    local indirectOrbits = 0
    while not (a == b) do
        if withPath then table.insert(path, a) end
        a = orbits[a]
        indirectOrbits = indirectOrbits + 1
    end
    return indirectOrbits, path
end

local function getOrbIntersection(a, b)
    local _, pathA = getOrbDistance(a, "COM", true)
    local _, pathB = getOrbDistance(b, "COM", true)
    local pathC = {}
    for _, v in ipairs(pathA) do
        for _, v2 in ipairs(pathB) do
            if v == v2 then table.insert(pathC, v) end
        end
    end
    local c
    for _, v in ipairs(pathC) do
        local result1 = getOrbDistance(a, v)
        local result2 = getOrbDistance(b, v)
        if not c then
            c = result1 + result2
        elseif c > result1 + result2 then
            c = result1 + result2
            print(c)
        end
    end
    return c - 2
end

local function totalOrbits2COM()
    local indirectOrbits = 0
    local directOrbits = 0
    for _, b in pairs(orbits) do
        local orbit = b
        indirectOrbits = indirectOrbits + getOrbDistance(orbit, "COM")
        directOrbits = directOrbits + 1
    end
    return directOrbits + indirectOrbits
end
print("the answer 1 is: " .. totalOrbits2COM())
print("the answer 2 is: " .. getOrbIntersection("YOU", "SAN"))