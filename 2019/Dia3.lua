do
local file = io.open("Dia3.txt", "r") -- Se requiere un archivo Dia3.txt para ejecutar
local input = file:read("*a")
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

local function vec(x, y)
    return {x = x, y = y}
end

local function addVec(v1, v2)
    return {x = v1.x + v2.x, y = v1.y + v2.y}
end

local function distanceVec(v)
    return (math.abs(0 - v.x) + math.abs(0 - v.y))
end

-- Creamos la lista de cables
local cables = split(input, "[^\n]+")

-- Convertimos cada string cable en una tabla y la almacenamos en una nueva variable
local cablesTable = {}
for _, value in ipairs(cables) do
    table.insert(cablesTable, split(value, "([^,]+)"))
end
-- Convertimos cada instruccion en rutas y creamos una nueva tabla
local cablesPaths = {}
for _, cable in ipairs(cablesTable) do
    local t = {}
    local pointer = vec(0,0)
    for _, step in ipairs(cable) do
        local dir = step:sub(1,1)
        local steps = step:sub(2) -- eliminamos el primer caracter para obtener el numero de pasos
        if dir == "R" then
            dir = vec(1,0)
        elseif dir == "L" then
            dir = vec(-1,0)
        elseif dir == "U" then
            dir = vec(0,-1)
        elseif dir == "D" then
            dir = vec(0,1)
        else
            dir = vec(0,0)
        end
        for _=1, steps do
            pointer = addVec(dir, pointer)
            table.insert(t, pointer)
        end
    end
    table.insert(cablesPaths, t)
end

-- Obtenemos las intercepciones y calculamos las distancias
local distanceMin = nil
local stepsMin = nil
local t = {}
for i, value in ipairs(cablesPaths[1]) do
    local concat = value.x .. "," .. value.y
    t[concat] = i
end
for i, value in ipairs(cablesPaths[2]) do
    local concat = value.x .. "," .. value.y
    if t[concat] then
        local distance = distanceVec(value)
        local steps = t[concat] + i
        if distanceMin then
            if distance < distanceMin then distanceMin = distance end
        else
            distanceMin = distance
        end
        if stepsMin then
            if steps < stepsMin then stepsMin = steps end
        else
            stepsMin = steps
        end
    end
end
print("Answer 1 is: " .. distanceMin)
print("Answer 2 is: " .. stepsMin)
end
