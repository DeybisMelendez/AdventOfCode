local aoc = require "lib.aoc"

local input = aoc.input.getInput()
input = string.gsub(input, ":", "")
input = aoc.string.split(input, "\n")
for i = 1, #input do
    input[i] = aoc.string.split(input[i], "%s")
    for j = 1, #input[i] do
        input[i][j] = tonumber(input[i][j])
    end
end

local function isEquationCorrect(equation, total, i, op)
    if total > equation[1] then
        return false
    end
    if i == #equation + 1 then
        if total == equation[1] then
            return true
        end
        return false
    end
    if op.concat then
        local numDigits = math.floor(math.log10(equation[i]) + 1)
        if isEquationCorrect(equation, total * math.pow(10, numDigits) + equation[i], i + 1, op) then
            return true
        end
    end
    if op.mul then
        if isEquationCorrect(equation, total * equation[i], i + 1, op) then
            return true
        end
    end
    if op.add then
        if isEquationCorrect(equation, total + equation[i], i + 1, op) then
            return true
        end
    end
    return false
end

local function answer1()
    local total = 0
    local op = {
        add = true,
        mul = true
    }
    for _, equation in ipairs(input) do
        if isEquationCorrect(equation, equation[2], 3, op) then
            total = total + equation[1]
        end
    end
    return total
end
local function answer2()
    local total = 0
    local op = {
        add = true,
        mul = true,
        concat = true,
    }
    for _, equation in ipairs(input) do
        if isEquationCorrect(equation, equation[2], 3, op) then
            total = total + equation[1]
        end
    end
    return string.format("%0.0f", total)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
