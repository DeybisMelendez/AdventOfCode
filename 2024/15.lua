local aoc = require "lib.aoc"
local input = aoc.input.getInput()
local moves = input:gsub("[#@.O\n]+", "")
input = input:gsub("[%^<>v]+", "")
input = aoc.string.split(input, "\n")

local function getMapAndRobot()
    local map = {}
    local robot = {}
    for y, line in ipairs(input) do
        table.insert(map, {})
        map[y] = aoc.string.splitToChar(line)
        if robot.x == nil then
            for x, char in ipairs(map[y]) do
                if char == "@" then
                    robot.x = x
                    robot.y = y
                end
            end
        end
    end
    return map, robot
end

local function moveObject(x, y, move, map, robot)
    local nx, ny = x, y
    if move == "^" then
        ny = ny - 1
    elseif move == ">" then
        nx = nx + 1
    elseif move == "<" then
        nx = nx - 1
    elseif move == "v" then
        ny = ny + 1
    end
    if map[ny][nx] == "O" then
        moveObject(nx, ny, move, map, robot)
    end
    if (map[ny][nx] == "[" or map[ny][nx] == "]") and (move == ">" or move == "<") then
        moveObject(nx, ny, move, map, robot)
    end
    if map[ny][nx] == "." then
        local obj = map[y][x]
        map[y][x] = "."
        map[ny][nx] = obj
    end
    if map[ny][nx] == "@" then
        robot.x = nx
        robot.y = ny
    end
end

local function printMap(map)
    for y = 1, #map do
        for x = 1, #map[y] do
            io.write(map[y][x])
        end
        print()
    end
end

local function countBoxes(map)
    local count = 0
    for y = 2, #map - 1 do
        for x = 2, #map[y] - 1 do
            if map[y][x] == "O" or map[y][x] == "[" then
                count = count + (y - 1) * 100 + (x - 1)
            end
        end
    end
    return count
end

local function expandMap(map)
    for y = #map, 1, -1 do
        for x = #map[y], 1, -1 do
            if map[y][x] == "#" then
                table.insert(map[y], x + 1, "#")
            elseif map[y][x] == "." then
                table.insert(map[y], x + 1, ".")
            elseif map[y][x] == "O" then
                table.insert(map[y], x + 1, "]")
                map[y][x] = "["
            elseif map[y][x] == "@" then
                table.insert(map[y], x + 1, ".")
            end
        end
    end
    local robot = {}
    for y = 3, #map do
        for x = 2, #map[y] do
            if map[y][x] == "@" then
                robot.x = x
                robot.y = y
                return robot
            end
        end
    end
end

local function canPush(x, y, move, map)
    local ny = y
    if move == "^" then
        ny = ny - 1
    elseif move == "v" then
        ny = ny + 1
    end
    if map[y][x] == "[" then
        return canPush(x, ny, move, map) and canPush(x + 1, ny, move, map)
    elseif map[y][x] == "]" then
        return canPush(x, ny, move, map) and canPush(x - 1, ny, move, map)
    elseif map[y][x] == "." then
        return true
    end
    return false
end
local function push(x, y, move, map)
    local ny = y
    if move == "^" then
        ny = ny - 1
    elseif move == "v" then
        ny = ny + 1
    end
    if map[y][x] == "[" then
        push(x, ny, move, map)
        push(x + 1, ny, move, map)
        map[ny][x + 1] = "]"
        map[y][x + 1] = "."
        local obj = map[ny][x]
        map[ny][x] = map[y][x]
        map[y][x] = obj
    elseif map[y][x] == "]" then
        push(x, ny, move, map)
        push(x - 1, ny, move, map)
        map[ny][x - 1] = "["
        map[y][x - 1] = "."
        local obj = map[ny][x]
        map[ny][x] = map[y][x]
        map[y][x] = obj
    end
end

local function answer1()
    local map, robot = getMapAndRobot()
    --printMap(map)
    for i, move in ipairs(aoc.string.splitToChar(moves)) do
        --print("Paso:", i, "Pos:", robot.x, robot.y, "Move:", move)
        moveObject(robot.x, robot.y, move, map, robot)
        --printMap(map)
    end
    return countBoxes(map)
end

local function answer2()
    local map, _ = getMapAndRobot()
    local robot = expandMap(map)
    --printMap(map)
    for i, move in ipairs(aoc.string.splitToChar(moves)) do
        local x, y = robot.x, robot.y
        --print("Paso:", i, "Pos:", x, y, "Move:", move)
        if move == "^" and (map[y - 1][x] == "[" or map[y - 1][x] == "]") and canPush(x, y - 1, move, map) then
            push(x, y - 1, move, map)
        elseif move == "v" and (map[y + 1][x] == "[" or map[y + 1][x] == "]") and canPush(x, y + 1, move, map) then
            push(x, y + 1, move, map)
        end
        moveObject(robot.x, robot.y, move, map, robot)
        --printMap(map)
    end
    return countBoxes(map)
end
print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
