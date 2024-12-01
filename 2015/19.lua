local aoc = require "lib.aoc"

local function getInput()
    local input = aoc.input.getInput()
    input = aoc.string.split(input, "\n")
    input.starting = table.remove(input) -- pop last element
    input.replacements = {}
    for _, line in ipairs(input) do
        line = aoc.string.split(line, "%s")
        input.replacements[line[1]] = line[3]
    end
    return input
end

local function answer1()
    local input = getInput()
end

print("answer 1 is " .. answer1())
--print("answer 1 is " .. answer2())
