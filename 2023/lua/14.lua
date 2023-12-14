require "utils"

local DIR<const> = {
    NORTH = 1,
    WEST = 2,
    SOUTH = 3,
    EAST = 4
}

local memoizationTable = {}

local function moveRock(map, dir, x, y)
    if dir == DIR.NORTH then
        if y > 1 and map[y - 1][x] == "." then
            map[y][x] = "."
            map[y - 1][x] = "O"
            moveRock(map, dir, x, y - 1)
        end
    elseif dir == DIR.SOUTH then
        if y < #map and map[y + 1][x] == "." then
            map[y][x] = "."
            map[y + 1][x] = "O"
            moveRock(map, dir, x, y + 1)
        end
    elseif dir == DIR.WEST then
        if x > 1 and map[y][x - 1] == "." then
            map[y][x] = "."
            map[y][x - 1] = "O"
            moveRock(map, dir, x - 1, y)
        end
    elseif dir == DIR.EAST then
        if x < #map[y] and map[y][x + 1] == "." then
            map[y][x] = "."
            map[y][x + 1] = "O"
            moveRock(map, dir, x + 1, y)
        end
    end
end

local function getTotalLoad(map)
    local total = 0
    for y, line in ipairs(map) do
        for x, val in ipairs(line) do
            if val == "O" then
                total = total + #map - (y - 1)
            end
        end
    end
    return total
end

local function mapToString(map)
    local stringMap = ""
    for y, line in ipairs(map) do
        for x, val in ipairs(line) do
            stringMap = stringMap .. val
        end
        stringMap = stringMap .. "\n"
    end
    return stringMap
end

local function stringToMap(str, map)
    local lines = splitString(str, lineDelimiter)
    for i, line in ipairs(lines) do
        line = splitString(line, charDelimiter)
        map[i] = {}
        for j, char in ipairs(line) do
            map[i][j] = char
        end
    end
    return map
end

local function moveAllRocks(map, dir)
    if dir == DIR.NORTH then
        for y, line in ipairs(map) do
            for x, val in ipairs(line) do
                if val == "O" then
                    moveRock(map, dir, x, y)
                end
            end
        end
    elseif dir == DIR.SOUTH then
        for y = #map, 1, -1 do
            for x, val in ipairs(map[y]) do
                if val == "O" then
                    moveRock(map, dir, x, y)
                end
            end
        end
    elseif dir == DIR.EAST then
        for y, line in ipairs(map) do
            for x = #line, 1, -1 do
                if line[x] == "O" then
                    moveRock(map, dir, x, y)
                end
            end
        end
    elseif dir == DIR.WEST then
        for y, line in ipairs(map) do
            for x = 1, #line do
                if line[x] == "O" then
                    moveRock(map, dir, x, y)
                end
            end
        end
    end

end

local function getInput()
    local input = readFile("14.input")
    return stringToMap(input, {})
end

local function answer1()
    local map = getInput()
    moveAllRocks(map, DIR.NORTH)
    return getTotalLoad(map)
end

local function answer2()
    local map = getInput()
    local reps = 0
    local repFrom = 0
    local i = 1

    while true do
        local memoKey = mapToString(map)
        if memoizationTable[memoKey] then
            reps = i - memoizationTable[memoKey]
            repFrom = memoizationTable[memoKey]
            break
        else
            moveAllRocks(map, DIR.NORTH)
            moveAllRocks(map, DIR.WEST)
            moveAllRocks(map, DIR.SOUTH)
            moveAllRocks(map, DIR.EAST)
            memoizationTable[memoKey] = i
        end
        i = i + 1
    end

    local left = 1 + (1000000000 - repFrom) % reps

    for i = 1, left do
        moveAllRocks(map, DIR.NORTH)
        moveAllRocks(map, DIR.WEST)
        moveAllRocks(map, DIR.SOUTH)
        moveAllRocks(map, DIR.EAST)
    end

    return getTotalLoad(map)
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
