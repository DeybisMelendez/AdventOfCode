local aoc = require "lib.aoc"

local input = aoc.input.getInput()
local mulPattern = "mul%((%d+),(%d+)%)"
local dontDoPattern = "don't%(%)(.-)do%(%)"

local function getTotalMul(str)
    local total = 0
    local num = 0
    for n1, n2 in string.gmatch(str, mulPattern) do
        total = total + n1 * n2
        num = num + 1
    end
    return total
end

local function answer1()
    return getTotalMul(input)
end

local function answer2()
    local cleanedInput = string.gsub(input, dontDoPattern, "")
    return getTotalMul(cleanedInput)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
