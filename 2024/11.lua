local aoc = require "lib.aoc"
local numMemo = {}
local input = aoc.input.getInput()
input = aoc.string.split(input, "%s")

local function splitNumber(num)
    local numStr = tostring(num)
    local len = #numStr

    if len % 2 == 0 then
        local middlePoint = len / 2
        local part1 = tonumber(numStr:sub(1, middlePoint))
        local part2 = tonumber(numStr:sub(middlePoint + 1))

        return part1, part2
    else
        return nil, nil
    end
end

local function blink(num, depth)
    if depth == 0 then
        return 1
    end
    depth = depth - 1
    local memoKey = num .. "-" .. depth
    if numMemo[memoKey] then
        return numMemo[memoKey]
    end
    local total = 0
    local part1, part2 = splitNumber(num)
    if num == 0 then
        total = total + blink(1, depth)
    elseif part1 ~= nil then
        total = total + blink(part1, depth)
        total = total + blink(part2, depth)
    else
        total = total + blink(num * 2024, depth)
    end
    numMemo[memoKey] = total
    return total
end

local function answer1()
    local total = 0
    for _, num in ipairs(input) do
        total = total + blink(tonumber(num), 25)
    end
    return total
end
local function answer2()
    local total = 0
    for _, num in ipairs(input) do
        total = total + blink(tonumber(num), 75)
    end
    return string.format("%0.0f", total)
end
print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
