local json = require "json" --https://github.com/rxi/json.lua
local file = io.open("day12input.txt", "r")
local text = file:read("*a")
file:close()

local function getSum(t)
    local total = 0
    for i, v in pairs(t) do
        if type(v) == "number" then
            total = total + v
        elseif type(v) == "table" then
            total = total + getSum(v)
        end
    end
    return total
end
--[[ Metodo sin librería json
    local function answer1(str)
    local sum = 0
    local i = 1
    while i < #str do
        local num = ""
        local char = string.sub(str, i,i)
        if tonumber(char) ~= nil then
            local symbol = string.sub(str, i-1,i-1)
            if symbol == "-" then
                num = symbol
            end
            while tonumber(string.sub(str, i,i)) ~= nil do
                num = num .. string.sub(str, i,i)
                i = i + 1
            end
        end
        if tonumber(num) ~= nil then
            sum = sum + tonumber(num)
        end
        i = i + 1
    end
    return sum
end]]

local function answer1(str)
    local decode = json.decode(str)
    local result = getSum(decode)
    return result
end

local function deleteRed(t)
    for i,v in pairs(t) do
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

local function answer2(str)
    local decode = json.decode(str)
    local newjson = deleteRed(decode)
    local result = getSum(newjson)
    return result
end

print(answer1(text))
print(answer2(text))