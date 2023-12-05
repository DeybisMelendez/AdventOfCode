require "utils"

local input = readFile("03input.txt")
local partNumberFound = {}
local down = #splitString(input, lineDelimiter) + 1 -- se suma el salto de línea
local up = -down
local adjacents = {-1, up - 1, up, up + 1, 1, down + 1, down, down - 1}

local function readNumberOfIndex(index)
    local left = index
    local right = index
    local number = 0

    while left > 0 and tonumber(input:sub(left - 1, left - 1)) ~= nil do
        left = left - 1
        number = tonumber(input:sub(left, right))
        if number == nil then
            left = left + 1
            break
        end
    end

    while right <= #input and tonumber(input:sub(right + 1, right + 1)) ~= nil do
        right = right + 1
        number = tonumber(input:sub(left, right))
        if number == nil then
            right = right - 1
            break
        end
    end

    return tonumber(input:sub(left, right)), left, right
end

local function getSumOfParts(index)
    local char = ""
    local isNumber = false
    local left = 0
    local right = 0
    local number = 0
    local total = 0

    for i = 1, #adjacents do
        if adjacents[i] + index > 0 and adjacents[i] + index <= #input then
            char = input:sub(adjacents[i] + index, adjacents[i] + index)
            isNumber = tonumber(char) ~= nil
            if isNumber then
                if partNumberFound[adjacents[i] + index] == nil then
                    number, left, right = readNumberOfIndex(adjacents[i] + index)
                    for j = left, right do
                        partNumberFound[j] = true
                    end
                    total = total + number
                end
            end
        end
    end
    return total
end

local function getGearRatio(index)
    local char = ""
    local isNumber = false
    local left = 0
    local right = 0
    local number = 0
    local total = 0
    local parts = {}
    for i = 1, #adjacents do
        if adjacents[i] + index > 0 and adjacents[i] + index <= #input then
            char = input:sub(adjacents[i] + index, adjacents[i] + index)
            isNumber = tonumber(char) ~= nil
            if isNumber then
                if partNumberFound[adjacents[i] + index] == nil then
                    number, left, right = readNumberOfIndex(adjacents[i] + index)
                    for j = left, right do
                        partNumberFound[j] = true
                    end
                    table.insert(parts, number)
                end
            end
        end
    end
    if #parts == 2 then
        return parts[1] * parts[2]
    end
    return 0
end

local function answer1()
    partNumberFound = {} -- clear
    local char = ""
    local total = 0
    for i = 1, #input do
        char = input:sub(i, i)
        if tonumber(char) == nil and char ~= "." and char ~= "\n" then
            total = total + getSumOfParts(i)
        end
    end
    return total
end

local function answer2()
    partNumberFound = {} -- clear
    local char = ""
    local total = 0
    for i = 1, #input do
        char = input:sub(i, i)
        if char == "*" then
            total = total + getGearRatio(i)
        end
    end
    return total
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
