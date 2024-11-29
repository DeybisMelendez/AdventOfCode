local aoc = require "lib.aoc"
local input = aoc.input.getInput()
local bestMinContainer = 1000000
local minContainer = 0
local minCombinations = 0
input = aoc.string.split(input, "\n")
for i, container in ipairs(input) do
    input[i] = tonumber(container)
end

local function findCombinations(target, index)
    if target == 0 then
        if bestMinContainer > minContainer then
            bestMinContainer = minContainer
            minCombinations = 1
        elseif bestMinContainer == minContainer then
            minCombinations = minCombinations + 1
        end
        return 1
    end

    if target < 0 or index > #input then
        return 0
    end
    minContainer = minContainer + 1
    local actualCombination = findCombinations(target - input[index], index + 1)
    minContainer = minContainer - 1
    local nextCombination = findCombinations(target, index + 1)
    return actualCombination + nextCombination
end

local function answer1()
    bestMinContainer = 1000000
    minContainer = 0
    minCombinations = 0
    return findCombinations(25, 1)
end

local function answer2()
    bestMinContainer = 1000000
    minContainer = 0
    minCombinations = 0
    findCombinations(25, 1)
    return minCombinations
end

print("answer 1 is " .. answer1())
print("answer 1 is " .. answer2())
