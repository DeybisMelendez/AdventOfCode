local file = io.open("day04input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local lines = split(text, "[^\n]+")

local function answer1()
    local niceString = 0
    local vocals = {"a", "e", "i", "o", "u"}
    local notChars = {"ab", "cd", "pq", "xy"}
    for i=1, #lines do
        local str = lines[i]
        local vocalCount = 0
        local twice = false
        local contains = false
        for c=1, #str do
            for v=1, #vocals do
                if string.sub(str, c, c) == vocals[v] then
                    vocalCount = vocalCount + 1
                end
            end
            if c < #str then
                if string.sub(str, c, c) == string.sub(str, c+1, c+1) then
                    twice = true
                end
                for v=1, #vocals do
                    if string.sub(str, c, c+1) == notChars[v] then
                        contains = true
                    end
                end
            end
        end
        if vocalCount >= 3 and twice and not contains then
            niceString = niceString + 1
        end
    end
    return niceString
end

local function answer2()
    local niceString = 0
    for i=1, #lines do
        local str = lines[i]
        local rep = false
        local bet = false
        for c=1, 15 do
            local chars = string.sub(str, c, c+1)
            for c2=1, 15 do
                local chars2 = string.sub(str, c2, c2+1)
                if chars == chars2 and not(c == c2) and not(c == c2 + 1) and not(c + 1 == c2) then
                    rep = true
                end
            end
        end
        for c=1, 14 do
            if string.sub(str, c, c) == string.sub(str, c+2, c+2) then
                bet = true
            end
        end
        if rep and bet then
            --print(str)
            niceString = niceString + 1
        end
    end
    return niceString
end

print(answer1())
print(answer2())
