local aoc = require "lib.aoc"
local numbers = "0123456789"
local input = aoc.string.split(aoc.input.getInput(), ",")
for i = 1, #input do
    input[i] = aoc.string.split(input[i], "-")
end

local function answer1()
    local total = 0
    for i = 1, #input do
        local first = tonumber(input[i][1])
        local second = tonumber(input[i][2])
        for j = first, second do
            local hasDouble = true
            local isRepeating = false
            for n = 1, #numbers do
                local number = numbers:sub(n, n)
                local count = aoc.string.count(tostring(j), number)
                if count % 2 ~= 0 then
                    hasDouble = false
                    break
                end
            end
            local part1 = tostring(j):sub(1, #tostring(j) / 2)
            local part2 = tostring(j):sub(#tostring(j) / 2 + 1)
            if part1 == part2 then
                isRepeating = true
            end
            if hasDouble and isRepeating then
                total = total + j
                --print("invalid number: " .. j)
            end
        end
    end
    return total
end

local function answer2()
    local total = 0
    for i = 1, #input do
        local first = tonumber(input[i][1])
        local second = tonumber(input[i][2])
        for j = first, second do
            local hasDouble = true
            local isRepeating = false
            for n = 1, #numbers do
                local number = numbers:sub(n, n)
                local count = aoc.string.count(tostring(j), number)
                if count > 1 then
                    hasDouble = false
                    break
                end
            end
            local part1 = tostring(j):sub(1, #tostring(j) / 2)
            local part2 = tostring(j):sub(#tostring(j) / 2 + 1)
            if part1 == part2 then
                isRepeating = true
            end
            if hasDouble then
                total = total + j
                --print("invalid number: " .. j)
            end
        end
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
--5397037056 es muy baja
