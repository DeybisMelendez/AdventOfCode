local file = io.open("Dia10.txt", "r") -- Se requiere un archivo Dia6.txt para ejecutar
local text = file:read("*a")
file:close()

-- Funcion que divide una cadena de texto con un delimitador
local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch("[^" .. del .. "]+") do
        table.insert(t, value)
    end
    return t
end
local arrays = split(text, "\n")
local input = {}
for index, array in ipairs(arrays) do
    for char=1, array:len() do
        if not input[index] then input[index] = {} end
        table.insert(input[index], array:sub(char, char))
    end
end

local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end

local function getAngle(x, y) -- devuelve grados hasta 360
    local a = math.atan2(y, x) + math.pi/2
    if a <= 0 then a = math.pi*2 - math.abs(a) end
    if a == math.pi*2 then a = 0 end
    return a
end

local function tableHas(t, v)
    for _, value in ipairs(t) do
        if value == v then return true end
    end
    return false
end

local function distanceBetween(x1, y1, x2, y2)
    return (x2 - x1)^2 + (y2 - y1)^2 -- no es necesario sacar la raiz cuadrada para comparar
end

local function getAnswer1(i)
    local maxAsteroids
    local totalAsteroids
    for y1, _ in ipairs(i) do
        for x1, value1 in ipairs(i[y1]) do
            if value1 == "#" then
                local vectorViews = {}
                local asteroids = {}
                for y2, _ in ipairs(i) do
                    for x2, value2 in ipairs(i[y2]) do
                        if value2 == "#" then
                            -- funciona no eliminando el mismo asteroide donde se instala
                            if true then --not(x1 == x2) and not(y1 == y2) then
                                local angle = getAngle(x2-x1, y2-y1)
                                table.insert(asteroids, {pos = {x2,y2}, angle = angle, distance = distanceBetween(x1, y1, x2, y2)})
                                if not tableHas(vectorViews, angle) then
                                    table.insert(vectorViews, angle)
                                end
                            end
                        end
                    end
                end
                if maxAsteroids == nil or maxAsteroids < #vectorViews then
                    maxAsteroids = #vectorViews
                    totalAsteroids = copyTable(asteroids)
                    totalAsteroids["pos"] = {x1-1,y1-1} --el mapa comienza con 1 y no 0, pinche lua y sus tablas :)
                end
            end
        end
    end
    return maxAsteroids, totalAsteroids
end
local answer1, asteroids = getAnswer1(input)

local function getAnswer2(ast)
    local sort = {}
    while #ast > 0 do
        local best, angle
        for i, value in ipairs(ast) do
            if angle == nil or angle > value.angle then
                best = i
                angle = value.angle
            end
        end
        table.insert(sort, ast[best])
        table.remove(ast, best)
    end
    local shots = 0
    local angle = sort[1].angle -- arriba ajustado
    local result
    while shots < 200 do
        -- Eliminamos el asteroide con angulo actual (0) que tenga distancia mas corta
        local best, distance = 0, nil
        for i, value in ipairs(sort) do
            if value.angle == angle then
                if (distance == nil) or (distance > value.distance) then
                    best = i
                    distance = value.distance
                end
            end
        end
        result = copyTable(sort[best])
        table.remove(sort, best)
        shots = shots + 1
        local done = false
        for _, value in ipairs(sort) do
            if value.angle > angle and not done then
                angle = value.angle
                done = true
            end
        end
        if angle == math.pi*2 then angle = 0 end
    end
    return (result["pos"][1]-1)*100 + (result["pos"][2]-1) -- el mapa comienza en 1 y no 0, por eso se debe restar 1
end

print("answer 1 is", answer1, "position is", asteroids["pos"][1], asteroids["pos"][2])

print("answer 2 is", getAnswer2(asteroids))