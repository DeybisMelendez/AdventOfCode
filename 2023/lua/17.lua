require "utils"

local DIR<const> = {
    LEFT = 1,
    RIGHT = 2,
    UP = 3,
    DOWN = 4
}

local minHeatLoss = 1000000000
local visited = {}
local memoTable = {}

local function getInput()
    local input = readFile("17.input")
    local lines = splitString(input, lineDelimiter)
    local map = {}
    map.height = #lines
    for i, line in ipairs(lines) do
        map[i] = {}
        line = splitString(line, charDelimiter)
        if i == 1 then
            map.width = #line
        end
        for j, char in ipairs(line) do
            map[i][j] = tonumber(char)
        end
    end
    return map
end

local function isVisited(pos)
    for i = 1, #visited - 1 do
        if visited[i].x == pos.x and visited[i].y == pos.y then
            return true
        end
    end
    return false
end

local function printLavafall(lavapool, pos, dir, actual, min)
    os.execute("clear")
    print("pos: " .. pos.x .. ", " .. pos.y, "dirCode: " .. dir, "ActualHeatLoss: " .. actual, "MinHeatLoss: " .. min,
        "visited: " .. #visited)
    for y, line in ipairs(lavapool) do
        for x, number in ipairs(line) do
            if pos.x == x and pos.y == y then
                io.write("@")
            elseif isVisited({
                x = x,
                y = y
            }) then
                io.write("x")
            else
                io.write(".")
            end
        end
        io.write("\n")
    end
    -- os.execute("sleep 0.01")
end

local function lavafall(lavapool, pos, dir, repdir, target, actualHeatLoss)
    if pos.x == target.x and pos.y == target.y then
        if actualHeatLoss + lavapool[pos.y][pos.x] < minHeatLoss then
            minHeatLoss = actualHeatLoss + lavapool[pos.y][pos.x]
            print(minHeatLoss)
        end
        return -- break search

    end
    if pos.x <= 0 or pos.x > lavapool.width or pos.y <= 0 or pos.y > lavapool.height then
        return -- break search
    end
    -- cutoff
    if actualHeatLoss >= minHeatLoss then
        return
    end
    if isVisited(pos) then
        return
    end
    -- print((actualHeatLoss / #visited))
    if ((math.abs(pos.x - target.x) + math.abs(pos.y - target.y) - 1)) * 4 + actualHeatLoss > minHeatLoss then
        return
    end

    local newPos = {}
    actualHeatLoss = actualHeatLoss + lavapool[pos.y][pos.x]
    -- printLavafall(lavapool, pos, dir, actualHeatLoss, minHeatLoss)

    if repdir < 3 then
        if dir == DIR.RIGHT then
            newPos = {
                x = pos.x + 1,
                y = pos.y
            }
        elseif dir == DIR.LEFT then
            newPos = {
                x = pos.x - 1,
                y = pos.y
            }
        elseif dir == DIR.UP then
            newPos = {
                x = pos.x,
                y = pos.y - 1
            }
        elseif dir == DIR.DOWN then
            newPos = {
                x = pos.x,
                y = pos.y + 1
            }
        end
        table.insert(visited, newPos)
        lavafall(lavapool, newPos, dir, repdir + 1, target, actualHeatLoss)
        table.remove(visited, #visited)
    end

    if dir == DIR.RIGHT or dir == DIR.LEFT then -- Turn 90 degrees
        -- DOWN
        newPos = {
            x = pos.x,
            y = pos.y + 1
        }
        table.insert(visited, newPos)
        lavafall(lavapool, newPos, DIR.DOWN, 1, target, actualHeatLoss)

        table.remove(visited, #visited)
        -- UP
        newPos = {
            x = pos.x,
            y = pos.y - 1
        }
        table.insert(visited, newPos)
        lavafall(lavapool, newPos, DIR.UP, 1, target, actualHeatLoss)
        table.remove(visited, #visited)

    end
    if dir == DIR.UP or dir == DIR.DOWN then
        -- RIGHT
        newPos = {
            x = pos.x + 1,
            y = pos.y
        }
        table.insert(visited, newPos)
        lavafall(lavapool, newPos, DIR.RIGHT, 1, target, actualHeatLoss)
        table.remove(visited, #visited)
        -- LEFT
        newPos = {
            x = pos.x - 1,
            y = pos.y
        }
        table.insert(visited, newPos)
        lavafall(lavapool, newPos, DIR.LEFT, 1, target, actualHeatLoss)
        table.remove(visited, #visited)
    end
end

local function answer1()
    local lavapool = getInput()
    local target = {
        x = lavapool.width,
        y = lavapool.height
    }
    local pos = {
        x = 1,
        y = 1
    }
    minHeatLoss = 1126
    lavafall(lavapool, pos, DIR.RIGHT, 0, target, 0)
    lavafall(lavapool, pos, DIR.DOWN, 0, target, 0)
    return minHeatLoss - lavapool[1][1]
end
print(answer1())
-- menor a 1122
