require "utils" -- utils.lua
local lineDelimiter = "[^\n]+"

local numbers = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

-- Encuentra el valor de calibracion de una linea
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

-- answer1 devuelve la respuesta de la parte 1
local function answer1()
    local input = readFile("01input.txt")
    local lines = splitString(input, lineDelimiter)
    local result = 0
    for _, line in ipairs(lines) do
        result = result + foundCalibrationValue(line, false)
    end
    return result
end

-- answer2 devuelve la respuesta de la parte 2
local function answer2()
    local input = readFile("01input.txt")
    local lines = splitString(input, lineDelimiter)
    local result = 0
    for _, line in ipairs(lines) do
        result = result + foundCalibrationValue(line, true)
    end
    return result
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
