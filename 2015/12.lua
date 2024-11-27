local aoc = require "lib.aoc"
local json = require "lib.json"
local input = aoc.input.getInput()
local inputDecoded = json.decode(input)

local function getSum(t)
    local total = 0
    for _, v in pairs(t) do
        if type(v) == "number" then
            total = total + v
        elseif type(v) == "table" then
            total = total + getSum(v)
        end
    end
    return total
end

local function deleteRed(t)
    for i, v in pairs(t) do
        if v == "red" and type(i) == "string" then
            t = nil
            break
        elseif type(v) == "table" then
            t[i] = deleteRed(v)
        else
        end
    end
    return t
end

local function answer1()
    local result = getSum(inputDecoded)
    return result
end

local function answer2()
    local newjson = deleteRed(inputDecoded)
    local result = getSum(newjson)
    return result
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
