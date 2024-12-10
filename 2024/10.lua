local aoc = require "lib.aoc"
local trailsMemo = {}
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    local split = {}
    for char in line:gmatch(".") do
        table.insert(split, tonumber(char))
    end
    input[i] = split
end
local width = #input[1]
local height = #input
local countUniques = true

local function countTrails(x, y)
    if input[y][x] == 9 then
        if countUniques then
            local memoKey = x .. "-" .. y
            if trailsMemo[memoKey] then
                return 0
            end
            trailsMemo[memoKey] = true
        end
        return 1
    end
    local totalTrails = 0
    local next = input[y][x] + 1
    if x > 1 then
        if input[y][x - 1] == next then
            totalTrails = totalTrails + countTrails(x - 1, y)
        end
    end
    if x < width then
        if input[y][x + 1] == next then
            totalTrails = totalTrails + countTrails(x + 1, y)
        end
    end
    if y > 1 then
        if input[y - 1][x] == next then
            totalTrails = totalTrails + countTrails(x, y - 1)
        end
    end
    if y < height then
        if input[y + 1][x] == next then
            totalTrails = totalTrails + countTrails(x, y + 1)
        end
    end
    return totalTrails
end

local function answer1()
    local total = 0
    countUniques = true
    for y = 1, height do
        for x = 1, width do
            if input[y][x] == 0 then
                trailsMemo = {}
                total = total + countTrails(x, y)
            end
        end
    end
    return total
end

local function answer2()
    local total = 0
    countUniques = false
    for y = 1, height do
        for x = 1, width do
            if input[y][x] == 0 then
                trailsMemo = {}
                total = total + countTrails(x, y)
            end
        end
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
