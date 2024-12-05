local aoc = require "lib.aoc"

local inputText = aoc.input.getInput()
local input = {}
input.pageOrder = inputText:match("(.*)\n\n")
input.pageUpdate = inputText:match(".*\n\n(.*)")

input.pageOrder = aoc.string.split(input.pageOrder, "\n")
input.pageUpdate = aoc.string.split(input.pageUpdate, "\n")

local orderMemo = {}

for _, page in ipairs(input.pageOrder) do
    page = aoc.string.split(page, "|")
    if not orderMemo[page[1]] then
        orderMemo[page[1]] = { next = {}, before = {} }
    end
    if not orderMemo[page[2]] then
        orderMemo[page[2]] = { next = {}, before = {} }
    end
    orderMemo[page[1]].next[page[2]] = true
    orderMemo[page[2]].before[page[1]] = true
end

local function getMiddle(update)
    return update[math.floor((#update / 2) + 0.5)]
end

local function isUpdateCorrect(update)
    local updateCorrect = true
    for i, num in ipairs(update) do
        for j = i + 1, #update do
            if not orderMemo[num].next[update[j]] then
                updateCorrect = false
                break
            end
        end
        for j = i - 1, 1, -1 do
            if not orderMemo[num].before[update[j]] then
                updateCorrect = false
                break
            end
        end
        if not updateCorrect then
            break
        end
    end
    return updateCorrect
end

local function orderUpdate(update)
    for i, num in ipairs(update) do
        for j = i + 1, #update do
            if not orderMemo[num].next[update[j]] then
                local copy = update[i]
                update[i] = update[j]
                update[j] = copy
                return orderUpdate(update)
            end
        end
        for j = i - 1, 1, -1 do
            if not orderMemo[num].before[update[j]] then
                local copy = update[i]
                update[i] = update[j]
                update[j] = copy
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
