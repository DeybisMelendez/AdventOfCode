local aoc = require "lib.aoc"
local input = aoc.input.getInput()
local abc = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" }

local function passID(pass)
    local t = {}
    for _, char in aoc.string.iterate(pass) do
        table.insert(t, aoc.list.indexOf(abc, char))
    end
    return t
end

local function hasIOL(pass)
    for _, v in pairs(pass) do
        if v == 9 or v == 12 or v == 15 then
            return true
        end
    end
    return false
end

local function hasInc(pass)
    for i = 1, #pass - 2 do
        local c1, c2, c3 = pass[i], pass[i + 1], pass[i + 2]
        if c1 + 1 == c2 and c2 == c3 - 1 then
            return true
        end
    end
    return false
end

local function hasTwoPairs(pass)
    local pairs = 0
    local i = 1
    while i < #pass do
        local c1, c2 = pass[i], pass[i + 1]
        if c1 == c2 then
            pairs = pairs + 1
            i = i + 1
        end
        i = i + 1
    end
    if pairs == 2 then return true end
    return false
end

local function incrementPass(pass, i)
    if pass[i] == 26 then
        pass[i] = 1
        return incrementPass(pass, i - 1)
    else
        pass[i] = pass[i] + 1
        return pass
    end
end

local function idToStr(pass)
    local result = ""
    for i = 1, #pass do
        result = result .. abc[pass[i]]
    end
    return result
end

local function getNextPass(pass)
    pass = passID(pass)
    while (not hasIOL(pass) and hasInc(pass) and hasTwoPairs(pass)) == false do
        pass = incrementPass(pass, 8)
    end
    return idToStr(pass)
end

local function answer1()
    return getNextPass(input)
end

local function answer2()
    local newInput = getNextPass(input)
    newInput = passID(newInput)
    newInput = incrementPass(newInput, 8)
    newInput = idToStr(newInput)
    return getNextPass(newInput)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
