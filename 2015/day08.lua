local file = io.open("day08input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local strings = split(text, "[^\n]+")
local totalCharsLit = 0
local totalCharsMem = 0
local totalNewlyEncodedChars = 0

local function answer1()
    for _,v in ipairs(strings) do
        totalCharsLit = totalCharsLit + #v
        v = string.sub(v,2,-2)
        v = string.gsub(v, "\\\\", "\\")
        v = string.gsub(v, "\\\"", "\"")
        v = string.gsub(v, "\\x%x%x",".")
        totalCharsMem = totalCharsMem + #v
    end
    return totalCharsLit - totalCharsMem
end

local function answer2()
    for _,v in ipairs(strings) do
        v = string.sub(v,2,-2)
        v = string.gsub(v, "\\\\", "1234")
        v = string.gsub(v, "\\\"", "1234")
        v = string.gsub(v, "\\x%x%x","12345")
        totalNewlyEncodedChars = totalNewlyEncodedChars + #v + 6
    end
    return totalNewlyEncodedChars - totalCharsLit
end

print(answer1())
print(answer2())