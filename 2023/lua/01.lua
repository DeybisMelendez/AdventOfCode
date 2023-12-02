require "utils" -- utils.lua
local lineDelimiter = "[^\n]+"

local function foundCalibrationValue(line)
    local firstDigit = ""
    local lastDigit = ""
    for i = 1, #line do
        local char = line:sub(i,i)
        if tonumber(char) ~= nil then
            firstDigit = char
            break
        end
    end
    for i = #line, 1,-1  do
        local char = line:sub(i,i)
        if tonumber(char) ~= nil then
            lastDigit = char
            break
        end
    end
    return tonumber(firstDigit..lastDigit)
end

-- answer1 devuelve la respuesta del reto
local function answer1()
    local input = readFile("01input.txt")
    local lines = splitString(input, lineDelimiter)
    local result = 0
    for _, line in ipairs(lines) do
        result = result + foundCalibrationValue(line)
    end
    return result
end

print("Parte 1:",answer1())