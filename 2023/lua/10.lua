require "utils"

local DIR<const> = {
    north = 1,
    east = 2,
    south = 3,
    west = 4
}
local PIPE<const> = {
    -- Norte, Este, Sur, Oeste
    ["|"] = {DIR.north, nil, DIR.south, nil},
    ["-"] = {nil, DIR.east, nil, DIR.west},
    ["L"] = {nil, nil, DIR.east, DIR.north},
    ["J"] = {nil, DIR.north, DIR.west, nil},
    ["7"] = {DIR.west, DIR.south, nil, nil},
    ["F"] = {DIR.east, nil, nil, DIR.south},
    ["."] = {nil, nil, nil, nil}
}

local function getPipeOfS(dirs)

    if contains(dirs, DIR.north) and contains(dirs, DIR.south) then
        return "|"
    elseif contains(dirs, DIR.east) and contains(dirs, DIR.west) then
        return "-"
    elseif contains(dirs, DIR.east) and contains(dirs, DIR.north) then
        return "L"
    elseif contains(dirs, DIR.north) and contains(dirs, DIR.west) then
        return "J"
    elseif contains(dirs, DIR.west) and contains(dirs, DIR.south) then
        return "7"
    elseif contains(dirs, DIR.east) and contains(dirs, DIR.south) then
        return "F"
    end
end

local function getInput()
    local input = readFile("10.input")
    local lines = splitString(input, lineDelimiter)
    local map = {}
    for i, line in ipairs(lines) do
        line = splitString(line, ".")
        map[i] = {}
        for j, char in ipairs(line) do
            map[i][j] = char
            if char == "S" then
                map.S = {
                    x = j,
                    y = i
                }
            end
        end
    end
    return map
end

local function getValidDirection(map)
    local valids = {}
    local west = {
        x = map.S.x - 1,
        y = map.S.y
    }
    local east = {
        x = map.S.x + 1,
        y = map.S.y
    }
    local north = {
        x = map.S.x,
        y = map.S.y - 1
    }
    local south = {
        x = map.S.x,
        y = map.S.y + 1
    }

    if west.x > 0 then
        if PIPE[map[west.y][west.x]][DIR.west] ~= nil then
            table.insert(valids, DIR.west)
        end
    end
    if east.x <= #map[1] then
        if PIPE[map[east.y][east.x]][DIR.east] ~= nil then
            table.insert(valids, DIR.east)
        end
    end
    if north.y > 0 then
        if PIPE[map[north.y][north.x]][DIR.north] ~= nil then
            table.insert(valids, DIR.north)
        end
    end
    if south.y <= #map then
        if PIPE[map[south.y][south.x]][DIR.south] ~= nil then
            table.insert(valids, DIR.south)
        end
    end
    return valids
end

local function getNewPos(maxY, maxX, pos, direction)
    local newPos = {}
    if direction == DIR.east and pos.x + 1 <= maxX then
        newPos.x = pos.x + 1
        newPos.y = pos.y
        return newPos
    end
    if direction == DIR.west and pos.x - 1 > 0 then
        newPos.x = pos.x - 1
        newPos.y = pos.y
        return newPos
    end
    if direction == DIR.north and pos.y - 1 > 0 then
        newPos.x = pos.x
        newPos.y = pos.y - 1
        return newPos
    end
    if direction == DIR.south and pos.y + 1 <= maxY then
        newPos.x = pos.x
        newPos.y = pos.y + 1
        return newPos
    end
    return nil
end

local function answer1()
    local map = getInput()
    local dir = getValidDirection(map)[1]
    local maxX, maxY = #map[1], #map
    local actualPipe = ""
    local steps = 1 -- contando la posición inicial
    local pos = {
        x = map.S.x,
        y = map.S.y
    }
    while true do
        -- Primero nos trasladamos a la siguiente posición en la dirección actual
        pos = getNewPos(maxY, maxX, pos, dir)
        -- Verificamos que no volvimos a la posición inicial
        if map.S.x == pos.x and map.S.y == pos.y then
            break
        end
        -- Revisamos que tipo de tubería estamos
        actualPipe = map[pos.y][pos.x]
        -- Obtenemos nueva dirección basada en el tipo de tubería
        dir = PIPE[actualPipe][dir]
        -- sumamos el paso dado
        steps = steps + 1
    end
    return math.ceil(steps / 2) -- el camino mas largo es la mitad del circuito
end

local function answer2()
    local map = getInput()
    local circuit = {}
    local initialDirs = getValidDirection(map)
    local dir = initialDirs[1]
    local maxX, maxY = #map[1], #map
    local actualPipe = ""
    local steps = 1 -- contando la posición inicial
    local maxSteps = 1
    local isInside = false
    local insideCount = 0
    for i = 1, maxY do
        circuit[i] = {}
        for j = 1, maxX do
            circuit[i][j] = "."
        end
    end
    local pos = {
        x = map.S.x,
        y = map.S.y
    }
    circuit[pos.y][pos.x] = getPipeOfS(initialDirs)
    -- similar a la respuesta uno, solo que ahora lo utilizo para crear un circuito "limpio"
    while true do
        pos = getNewPos(maxY, maxX, pos, dir)
        if map.S.x == pos.x and map.S.y == pos.y then
            break
        end
        circuit[pos.y][pos.x] = map[pos.y][pos.x]
        actualPipe = map[pos.y][pos.x]
        dir = PIPE[actualPipe][dir]
    end
    -- cuento fila a fila, si estoy "dentro" o "fuera" del circuito
    -- en teoría, si me encuentro una tubería que apunta al SUR "entro", y me topo con la siguiente que apunta al SUR "salgo"
    -- si la tubería no se dirige en paralelo (horizontal), solo "entro" o "salgo" si apunta en la misma dirección (SUR)
    -- en este sentido, la tubería "-", "J", "L" no indica cambio, mantengo el estado, ya que ninguna se dirige al sur.
    for _, y in ipairs(circuit) do
        -- Al inicio de cada fila siempre está afuera
        isInside = false
        for _, x in ipairs(y) do
            if x == "." and isInside then
                insideCount = insideCount + 1
                -- Si la tubería apunta al sur, cambia el estado, "entra" o "sale" del circuito
            elseif x == "|" or x == "7" or x == "F" then
                isInside = not isInside
            end
        end
    end
    return insideCount
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
