local aoc = require "lib.aoc"

local input = aoc.input.getInput()

local function answer1()
    local total = 0
    for n1, n2 in string.gmatch(input, "mul%((%d+),(%d+)%)") do
        total = total + n1 * n2
    end
    return total
end

local function answer2()
    local cleanedInput = string.gsub(input, "don't%(%)(.-)do%(%)", "")
    local total = 0
    for n1, n2 in string.gmatch(cleanedInput, "mul%((%d+),(%d+)%)") do
        total = total + n1 * n2
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
