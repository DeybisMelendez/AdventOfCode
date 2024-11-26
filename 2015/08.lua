local aoc = require "lib.aoc"

local input = aoc.string.split(aoc.input.getInput("input.txt"), "\n")
local totalCharsLit = 0
local totalCharsMem = 0
local totalNewlyEncodedChars = 0

local function answer1()
    for _, line in ipairs(input) do
        totalCharsLit = totalCharsLit + #line
        line = string.sub(line, 2, -2)
        line = string.gsub(line, "\\\\", "\\")
        line = string.gsub(line, "\\\"", "\"")
        line = string.gsub(line, "\\x%x%x", ".")
        totalCharsMem = totalCharsMem + #line
    end
    return totalCharsLit - totalCharsMem
end

local function answer2()
    for _, line in ipairs(input) do
        line = string.sub(line, 2, -2)
        line = string.gsub(line, "\\\\", "1234")
        line = string.gsub(line, "\\\"", "1234")
        line = string.gsub(line, "\\x%x%x", "12345")
        totalNewlyEncodedChars = totalNewlyEncodedChars + #line + 6
    end
    return totalNewlyEncodedChars - totalCharsLit
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
