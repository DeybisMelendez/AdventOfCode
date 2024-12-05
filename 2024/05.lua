local aoc = require "lib.aoc"

local inputText = aoc.input.getInput()
local input = {
    pageOrder = aoc.string.split(inputText:match("(.*)\n\n"), "\n"),
    pageUpdate = aoc.string.split(inputText:match(".*\n\n(.*)"), "\n"),
}

local orderMemo = {}

for _, page in ipairs(input.pageOrder) do
    local parts = aoc.string.split(page, "|")
    local first, second = parts[1], parts[2]

    if not orderMemo[first] then
        orderMemo[first] = { next = {}, before = {} }
    end
    if not orderMemo[second] then
        orderMemo[second] = { next = {}, before = {} }
    end

    orderMemo[first].next[second] = true
    orderMemo[second].before[first] = true
end

local function getMiddle(update)
    return update[math.floor((#update / 2) + 0.5)]
end

local function isUpdateCorrect(update)
    for i = 1, #update do
        local num = update[i]
        local nextMemo, beforeMemo = orderMemo[num].next, orderMemo[num].before

        for j = i + 1, #update do
            if not nextMemo[update[j]] then return false end
        end
        for j = i - 1, 1, -1 do
            if not beforeMemo[update[j]] then return false end
        end
    end
    return true
end

local function swap(update, i, j)
    update[i], update[j] = update[j], update[i]
end

local function orderUpdate(update)
    for i = 1, #update do
        local num = update[i]
        local nextMemo, beforeMemo = orderMemo[num].next, orderMemo[num].before

        for j = i + 1, #update do
            if not nextMemo[update[j]] then
                swap(update, i, j)
                return orderUpdate(update)
            end
        end
        for j = i - 1, 1, -1 do
            if not beforeMemo[update[j]] then
                swap(update, i, j)
                return orderUpdate(update)
            end
        end
    end
end

local function answer1()
    local total = 0
    for _, update in ipairs(input.pageUpdate) do
        update = aoc.string.split(update, ",")
        if isUpdateCorrect(update) then
            total = total + getMiddle(update)
        end
    end
    return total
end

local function answer2()
    local total = 0
    for _, update in ipairs(input.pageUpdate) do
        update = aoc.string.split(update, ",")
        if not isUpdateCorrect(update) then
            orderUpdate(update)
            total = total + getMiddle(update)
        end
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
