local aoc = require "lib.aoc"
local AntennaMemo = {}
local antinodeMemo = {}
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    input[i] = aoc.string.splitToChar(line)
end

local function answer1()
    local antinodes = 0
    for i = 1, #input do
        for j = 1, #input[i] do
            local char = input[i][j]
            if char ~= "." then
                local memoKey = i .. "-" .. j .. "-" .. char
                AntennaMemo[memoKey] = true
                for i2 = 1, #input do
                    for j2 = 1, #input[i] do
                        local char2 = input[i2][j2]
                        if char == char2 and not AntennaMemo[i2 .. "-" .. j2 .. "-" .. char] then
                            --local distI = (i2 - i) * 2
                            --local distJ = (j2 - j) * 2
                            local distI2 = i2 - i
                            local distJ2 = j2 - j
                            --[[if i2 - distI > 0 and j2 - distJ > 0 and i2 - distI <= #input and i2 - distJ <= #input[i] then
                                if input[i2 - distI][j2 - distJ] == "." then
                                    antinodes = antinodes + 1
                                end
                            end
                            if i + distI <= #input and j + distJ <= #input[i2] and i + distI > 0 and j + distJ > 0 then
                                if input[i + distI][j + distJ] == "." then
                                    antinodes = antinodes + 1
                                end
                            end]]
                            if i - distI2 > 0 and j - distJ2 > 0 and i - distI2 <= #input and i - distJ2 <= #input[i] then
                                if input[i - distI2][j - distJ2] == "." then
                                    print(1, char, i, j, i2, j2, i - distI2, j - distJ2)
                                    antinodes = antinodes + 1
                                end
                            end
                            if i2 + distI2 > 0 and j2 + distJ2 > 0 and i2 + distI2 <= #input and j2 + distJ2 <= #input[i2] then
                                if input[i2 + distI2][j2 + distJ2] == "." then
                                    print(2, char, i, j, i2, j2, i2 + distI2, j2 + distJ2)
                                    antinodes = antinodes + 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return antinodes
end

print("answer 1 is " .. answer1())
for k, _ in pairs(antinodeMemo) do
    print(k)
end
-- 371 muy alto
-- 321 muy baja
--print("answer 2 is " .. answer2())
