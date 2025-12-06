local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

local function parseInput()
    local parsedInput = {}
    for i = 1, #input - 1 do
        local line = aoc.string.split(input[i], "%s")
        for j = 1, #line do
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
    local parsedInput = parseInput()
    for i = 1, #parsedInput do
        local op = parsedInput.op[i]
        local result = parsedInput[i][1]

        for j = 2, #parsedInput[i] do
            if op == "*" then
                result = result * parsedInput[i][j]
            elseif op == "+" then
                result = result + parsedInput[i][j]
            end
        end
        total = total + result
    end
    return total
end

local function answer2()
    local total = 0
    local parsedInput = parseInput()
    local numbers = {}
    for i = 1, #parsedInput do
        local op = parsedInput.op[i]

        for j = 1, #parsedInput[i] do
            local number = parsedInput[i][j]
            local k = 1
            while number ~= 0 do
                local remain = number % 10
                number = math.floor(number / 10)
                if numbers[i] == nil then
                    numbers[i] = {}
                end
                if numbers[i][k] == nil then
                    numbers[i][k] = {remain}
                else
                    table.insert(numbers[i][k], remain)
                end
                k = k + 1
            end
        end
    end
    for i = 1, #numbers do
        local result = 0
        for j = 1, #numbers[i] do
            local num = ""
            local op = parsedInput.op[i]
            for k = 1, #numbers[i][j] do
                num = num .. numbers[i][j][k]
            end
            num = tonumber(num)
            if j == 1 then
                result = num
            elseif op == "*" then
                result = result * num
            elseif op == "+" then
                result = result + num
            end
            print(num)
        end
        print("= " .. result)
        total = total + result
    end
    return total
end

print("answer 1 is " .. answer1())
print("The answer 2 is: " .. answer2())
