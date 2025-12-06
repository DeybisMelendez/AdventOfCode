local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

for i=1, #input-1 do
    local line = aoc.string.split(input[i], "%s")
    for j=1, #line do
        line[j] = tonumber(line[j])
    end
    input[i] = line
end
input[#input] = aoc.string.split(input[#input], "%s")

local function parseInput()
    local parsedInput = {}
    for i=1, #input-1 do
        local line = aoc.string.split(input[i], "%s")
        for j=1, #line do
            if parsedInput[j] == nil then
                parsedInput[j] = {tonumber(line[j])}
            else
                table.insert(parsedInput[j], tonumber(line[j]))
            end
        end
    end
    parsedInput.op = aoc.string.split(input[#input], "%s")
    return parsedInput
end

local function answer1()
    local total = 0
    for j=1, #input[1] do
        local result = input[1][j]
        for i=2, #input-1 do
            local op = input[#input][j]
            print(input[i][j], op)
            if op == "*" then
                result = result * input[i][j]
            elseif op == "+" then
                result = result + input[i][j]
            end
        end
        total = total + result
    end
    return total
end

print("answer 1 is " .. answer1())