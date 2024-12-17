local aoc = require "lib.aoc"

local directions = { { 1, 0 }, { 0, 1 }, { -1, 0 }, { 0, -1 } }
local input = aoc.input.getInput()
local start = {}
local goal = {}
local visited = {}
input = aoc.string.split(input, "\n")
for y, line in ipairs(input) do
    input[y] = aoc.string.splitToChar(line)
    for x = 1, #input[y] do
        if input[y][x] == "E" then
            goal = { x = x, y = y }
            input[y][x] = "."
        elseif input[y][x] == "S" then
            start = { x = x, y = y }
            input[y][x] = "."
        end
    end
end

local function getLeftDir(dir)
    dir = dir - 1
    if dir < 1 then
        dir = 4
    end
    return dir
end

local function getRightDir(dir)
    dir = dir + 1
    if dir > 4 then
        dir = 1
    end
    return dir
end

local function mapScores(x, y, dir, actualScore)
    local leftDir = getLeftDir(dir)
    local rightDir = getRightDir(dir)
    local key = x .. "-" .. y

    if visited[key] and visited[key] <= actualScore then
        return
    end
    visited[key] = actualScore
    local nx, ny = x + directions[dir][1], y + directions[dir][2]
    if input[ny][nx] == "." then
        mapScores(nx, ny, dir, actualScore + 1)
    end
    nx, ny = x + directions[rightDir][1], y + directions[rightDir][2]
    if input[ny][nx] == "." then
        mapScores(nx, ny, rightDir, actualScore + 1001)
    end
    nx, ny = x + directions[leftDir][1], y + directions[leftDir][2]
    if input[ny][nx] == "." then
        mapScores(nx, ny, leftDir, actualScore + 1001)
    end
end



local function answer1()
    visited = {}
    mapScores(start.x, start.y, 1, 0)
    local goalKey = goal.x .. "-" .. goal.y
    return visited[goalKey]
end
local function answer2()
    visited = {}
    mapScores(goal.x, goal.y, 3, 0)
    local startKey = start.x .. "-" .. start.y
    return visited[startKey]
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
