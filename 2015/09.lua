local aoc = require "lib.aoc"
local input = aoc.input.getInput()
local distances = {}
local paths = {}

local function init()
    input = string.gsub(input, " to", "")
    input = string.gsub(input, " =", "")
    input = aoc.string.split(input, "\n")

    for _, distance in ipairs(input) do
        distance = aoc.string.split(distance, "%s")
        if distances[distance[1]] == nil then
            distances[distance[1]] = {}
        end
        if distances[distance[2]] == nil then
            distances[distance[2]] = {}
        end
        distances[distance[1]][distance[2]] = tonumber(distance[3])
        distances[distance[2]][distance[1]] = tonumber(distance[3])
    end
    local keys = aoc.dict.getKeys(distances)
    paths = aoc.list.permute(keys)
end

local function answer1()
    local bestDistance = 1000000000
    for _, path in pairs(paths) do
        local distance = 0
        for i = 1, #path - 1 do
            distance = distance + distances[path[i]][path[i + 1]]
        end
        if distance < bestDistance then
            bestDistance = distance
        end
    end
    return bestDistance
end

local function answer2()
    local bestDistance = 0
    for _, path in pairs(paths) do
        local distance = 0
        for i = 1, #path - 1 do
            distance = distance + distances[path[i]][path[i + 1]]
        end
        if distance > bestDistance then
            bestDistance = distance
        end
    end
    return bestDistance
end

init()
print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
