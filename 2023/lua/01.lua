require "utils"

local numbers = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

local function getInput()
    local input = readFile("01input.txt")
    return splitString(input, lineDelimiter)
end

local function foundCalibrationValue(line, readWords)
    local firstDigit = ""
    local lastDigit = ""
    local x, y = 0, 0

    if readWords then
        for i = 1, #numbers do
            x, y = string.find(line, numbers[i])
            if x ~= nil and y ~= nil then
                line = line:gsub(numbers[i], string.sub(numbers[i], 1, 1) .. i .. string.sub(numbers[i], -1))
            end
        end
    end

    for i = 1, #line do
        local char = line:sub(i, i)
        if tonumber(char) ~= nil then
            firstDigit = char
            break
        end
    end

    for i = #line, 1, -1 do
        local char = line:sub(i, i)
        if tonumber(char) ~= nil then
            lastDigit = char
            break
        end
    end

    if tonumber(firstDigit .. lastDigit) == nil then
        return 0
    end

    return tonumber(firstDigit .. lastDigit)
end

local function answer1()
    local lines = getInput()
    local result = 0
    for _, line in ipairs(lines) do
        result = result + foundCalibrationValue(line, false)
    end
    return result
end

local function answer2()
    local lines = getInput()
    local result = 0
    for _, line in ipairs(lines) do
        result = result + foundCalibrationValue(line, true)
    end
    return result
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
