local aoc = require "lib.aoc"

local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

local function min(a, b) return a < b end

local function answer1()
    local list1 = {}
    local list2 = {}
    local totalDistance = 0
    for _, line in ipairs(input) do
        line = aoc.string.split(line, "%s")
        table.insert(list1, tonumber(line[1]))
        table.insert(list2, tonumber(line[2]))
    end
    table.sort(list1, min)
    table.sort(list2, min)
    for i, id in ipairs(list1) do
        totalDistance = totalDistance + math.abs(id - list2[i])
    end
    return totalDistance
end

local function answer2()
    local list1 = {}
    local list2 = {}
    local totalSimilarityScore = 0
    for _, line in ipairs(input) do
        line = aoc.string.split(line, "%s")
        table.insert(list1, tonumber(line[1]))
        table.insert(list2, tonumber(line[2]))
    end
    for _, id in ipairs(list1) do
        for _, id2 in ipairs(list2) do
            if id == id2 then
                totalSimilarityScore = totalSimilarityScore + id
            end
        end
    end
    return totalSimilarityScore
end

print("answer 1 is " .. answer1())
print("answer 1 is " .. answer2())
