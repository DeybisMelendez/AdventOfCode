local aoc = require "lib.aoc"

local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    input[i] = aoc.string.splitToChar(line)
end
local XMAS = { "X", "M", "A", "S" }
local height = #input
local width = #input[1]

local function countXMAS(x, y)
    local count = 8
    if x + 3 <= width then
        -- right
        for i, char in ipairs(XMAS) do
            if input[x + i - 1][y] ~= char then
                count = count - 1
                break
            end
        end
        if y + 3 <= height then
            -- rightDown
            for i, char in ipairs(XMAS) do
                if input[x + i - 1][y + i - 1] ~= char then
                    count = count - 1
                    break
                end
            end
        else
            count = count - 1
        end
        if y - 3 >= 0 then
            -- rightUp
            for i, char in ipairs(XMAS) do
                if input[x + i - 1][y - i + 1] ~= char then
                    count = count - 1
                    break
                end
            end
        else
            count = count - 1
        end
    else
        count = count - 3
    end
    if y + 3 <= height then
        -- down
        for i, char in ipairs(XMAS) do
            if input[x][y + i - 1] ~= char then
                count = count - 1
                break
            end
        end
    else
        count = count - 1
    end
    if y - 3 > 0 then
        -- up
        for i, char in ipairs(XMAS) do
            if input[x][y - i + 1] ~= char then
                count = count - 1
                break
            end
        end
    else
        count = count - 1
    end
    if x - 3 > 0 then
        -- left
        for i, char in ipairs(XMAS) do
            if input[x - i + 1][y] ~= char then
                count = count - 1
                break
            end
        end
        if y + 3 <= height then
            -- leftDown
            for i, char in ipairs(XMAS) do
                if input[x - i + 1][y + i - 1] ~= char then
                    count = count - 1
                    break
                end
            end
        else
            count = count - 1
        end
        if y - 3 >= 0 then
            -- leftUp
            for i, char in ipairs(XMAS) do
                if input[x - i + 1][y - i + 1] ~= char then
                    count = count - 1
                    break
                end
            end
        else
            count = count - 1
        end
    else
        count = count - 3
    end
    return count
end

local function isValidXMAS(x, y)
    local count = 0
    if input[x - 1][y - 1] == "M" and input[x + 1][y + 1] == "S" then
        count = count + 1
    elseif input[x - 1][y - 1] == "S" and input[x + 1][y + 1] == "M" then
        count = count + 1
    end
    if input[x + 1][y - 1] == "M" and input[x - 1][y + 1] == "S" then
        count = count + 1
    elseif input[x + 1][y - 1] == "S" and input[x - 1][y + 1] == "M" then
        count = count + 1
    end
    return count == 2
end

local function answer1()
    local totalXMAS = 0
    for y = 1, height do
        for x = 1, width do
            if input[x][y] == "X" then
                totalXMAS = totalXMAS + countXMAS(x, y)
            end
        end
    end
    return totalXMAS
end

local function answer2()
    local totalXMAS = 0
    for y = 2, height - 1 do
        for x = 2, width - 1 do
            if input[x][y] == "A" and isValidXMAS(x, y) then
                totalXMAS = totalXMAS + 1
            end
        end
    end
    return totalXMAS
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
