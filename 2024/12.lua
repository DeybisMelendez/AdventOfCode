local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    input[i] = aoc.string.splitToChar(line)
end
local width = #input
local height = #input[1]
local regionMemo = {}
local mapMemo = {}
local directions = {
    { 1,  0 },
    { 0,  1 },
    { -1, 0 },
    { 0,  -1 }
}
local convexCorners = {
    { { -1, 0 }, { 0, 1 } },
    { { -1, 0 }, { 0, -1 } },
    { { 1, 0 },  { 0, 1 } },
    { { 1, 0 },  { 0, -1 } }
}
local concaveCorners = {
    { { -1, 0 }, { 0, 1 },  { -1, 1 } },
    { { -1, 0 }, { 0, -1 }, { -1, -1 } },
    { { 1, 0 },  { 0, 1 },  { 1, 1 } },
    { { 1, 0 },  { 0, -1 }, { 1, -1 } }
}

local function isInside(x, y)
    return x > 0 and x <= width and y > 0 and y <= height
end

local function getAreaAndPerimeter(x, y, char)
    local memoKey = x .. "-" .. y
    if regionMemo[memoKey] then
        return { 0, 0 }
    end

    if isInside(x, y) and input[x][y] == char then
        regionMemo[memoKey] = true
        mapMemo[memoKey] = true
        local total = { 1, 0 }
        for _, dir in ipairs(directions) do
            local data = getAreaAndPerimeter(x + dir[1], y + dir[2], char)
            total[1] = total[1] + data[1]
            total[2] = total[2] + data[2]
        end
        return total
    end
    return { 0, 1 }
end

local function getAreaAndSides(x, y, char)
    local memoKey = x .. "-" .. y
    if regionMemo[memoKey] then
        return { 0, 0 }
    end

    if isInside(x, y) and input[x][y] == char then
        regionMemo[memoKey] = true
        mapMemo[memoKey] = true
        local total = { 1, 0 }
        for _, corner in ipairs(convexCorners) do
            local x1, y1 = x + corner[1][1], y + corner[1][2]
            local x2, y2 = x + corner[2][1], y + corner[2][2]
            if (not isInside(x1, y1) or input[x1][y1] ~= char) and (not isInside(x2, y2) or input[x2][y2] ~= char) then
                total[2] = total[2] + 1
            end
        end
        for _, corner in ipairs(concaveCorners) do
            local x1, y1 = x + corner[1][1], y + corner[1][2]
            local x2, y2 = x + corner[2][1], y + corner[2][2]
            local x3, y3 = x + corner[3][1], y + corner[3][2]
            if (isInside(x1, y1) and input[x1][y1] == char) and (isInside(x2, y2) and input[x2][y2] == char) and
                (isInside(x3, y3) and input[x3][y3] ~= char) then
                total[2] = total[2] + 1
            end
        end
        for _, dir in ipairs(directions) do
            local data = getAreaAndSides(x + dir[1], y + dir[2], char)
            total[1] = total[1] + data[1]
            total[2] = total[2] + data[2]
        end
        return total
    end
    return { 0, 0 }
end

local function answer1()
    local totalPrice = 0
    mapMemo = {}
    for x in ipairs(input) do
        table.insert(mapMemo, {})
        for y in ipairs(input[x]) do
            local memoKey = x .. "-" .. y
            regionMemo = {}
            if not mapMemo[memoKey] then
                local data = getAreaAndPerimeter(x, y, input[x][y])
                totalPrice = totalPrice + data[1] * data[2]
            end
        end
    end
    return totalPrice
end

local function answer2()
    local totalPrice = 0
    mapMemo = {}
    for x in ipairs(input) do
        table.insert(mapMemo, {})
        for y in ipairs(input[x]) do
            local memoKey = x .. "-" .. y
            regionMemo = {}
            if not mapMemo[memoKey] then
                local data = getAreaAndSides(x, y, input[x][y])
                totalPrice = totalPrice + data[1] * data[2]
            end
        end
    end
    return totalPrice
end


print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
