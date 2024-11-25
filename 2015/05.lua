local aoc = require "lib.aoc"

local input = aoc.string.split(aoc.input.getInput("input.txt"),"\n")

local function answer1()
    local niceString = 0
    local vocals = {"a", "e", "i", "o", "u"}
    local notChars = {"ab", "cd", "pq", "xy"}
    for _, str in ipairs(input) do
        local vocalCount = 0
        local twice = false
        local contains = false
        for i, char in aoc.string.iterate(str) do
            for _, vocal in ipairs(vocals) do
                if char == vocal then
                    vocalCount = vocalCount + 1
                end
            end
            if i < #str then
                if str:sub(i, i) == str:sub(i+1, i+1) then
                    twice = true
                end
                for _, noChar in ipairs(notChars) do
                    if str:sub(i, i+1) == noChar then
                        contains = true
                        goto continue
                    end
                end
            end
        end
        ::continue::
        if vocalCount >= 3 and twice and not contains then
            niceString = niceString + 1
        end
    end
    return niceString
end

local function answer2()
    local niceString = 0
    for _, str in ipairs(input) do
        local rep = false
        local bet = false
        for c=1, 15 do
            local chars = str:sub(c, c+1)
            for c2=1, 15 do
                local chars2 = str:sub(c2, c2+1)
                if chars == chars2 and not(c == c2) and not(c == c2 + 1) and not(c + 1 == c2) then
                    rep = true
                    goto continue
                end
            end
        end
        ::continue::
        for c=1, 14 do
            if str:sub(c, c) == str:sub(c+2, c+2) then
                bet = true
                break
            end
        end
        if rep and bet then
            niceString = niceString + 1
        end
    end
    return niceString
end

print("the answer 1 is", answer1())
print("the answer 2 is", answer2())
