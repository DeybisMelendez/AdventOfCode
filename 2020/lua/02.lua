local utils = require"utils"

local INPUT = utils.readFile("02.input")

local function answer1(input)
    input = utils.split(input,utils.lineDelimiter)
    local validPasswords = 0
    for i, v in ipairs(input) do
        v = v:gsub("-"," ")
        v = v:gsub(":", "")
        local line = utils.split(v,utils.spaceDelimiter)
        local count = #line[4] - #line[4]:gsub(line[3],"")
        if count >= tonumber(line[1]) and count <= tonumber(line[2]) then
            validPasswords = validPasswords + 1
        end
    end
    return validPasswords
end

local function answer2(input)
    input = utils.split(input,utils.lineDelimiter)
    local validPasswords = 0
    for i, v in ipairs(input) do
        v = v:gsub("-"," ")
        v = v:gsub(":", "")
        local line = utils.split(v,utils.spaceDelimiter)
        local char1 = line[4]:sub(tonumber(line[1]) , tonumber(line[1]))
        local char2 = line[4]:sub(tonumber(line[2]),tonumber(line[2]))
        if (char1 == line[3] and char2 ~= line[3]) or (char1 ~= line[3] and char2 == line[3]) then
            validPasswords = validPasswords + 1
        end
    end
    return validPasswords
end

print("The answer 1 is", answer1(INPUT))
print("The answer 2 is", answer2(INPUT))