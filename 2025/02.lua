local aoc = require "lib.aoc"
local input = aoc.string.split(aoc.input.getInput(), ",")
for i = 1, #input do
    input[i] = aoc.string.split(input[i], "-")
end

local function isInvalidID(n)
    local s = tostring(n)
    local len = #s

    if len % 2 ~= 0 then
        return false
    end

    local mid = math.floor(len / 2)
    local a = s:sub(1, mid)
    local b = s:sub(mid+1)

    return a == b
end

local function isInvalidID2(n)
    local s = tostring(n)
    local len = #s

    for k = 1, math.floor(len/2) do
        if len % k == 0 then
            local block = s:sub(1, k)
            local repeat_ok = true

            for i = k+1, len, k do
                if s:sub(i, i+k-1) ~= block then
                    repeat_ok = false
                    break
                end
            end

            if repeat_ok then
                return true
            end
        end
    end

    return false
end

local function answer1()
    local total = 0

    for i = 1, #input do
        local first = tonumber(input[i][1])
        local second = tonumber(input[i][2])

        for j = first, second do
            if isInvalidID(j) then
                total = total + j
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
            if isInvalidID2(j) then
                total = total + j
            end
        end
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
