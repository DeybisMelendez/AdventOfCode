local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
local lineHeight = #input
local lineWidth = #input[1]
for i = 1, #input do
    input[i] = aoc.string.splitToChar(input[i])
end

local removables = {}

local function countAdjacents(x, y)
    local nx, ny, count = 0, 0, 0
    for dy = -1, 1 do
        for dx = -1, 1 do
            if not (dx == 0 and dy == 0) then
                nx = x + dx
                ny = y + dy

                if nx >= 1 and nx <= lineWidth and ny >= 1 and ny <= lineHeight then
                    if input[ny][nx] == "@" then
                        count = count + 1
                    end
                end
            end
        end
    end
    if count < 4 then
        table.insert(removables, {
            x = x,
            y = y
        })
        return true
    end
    return false
end

local function removeMarked()
    for _, pos in ipairs(removables) do
        local x, y = pos.x, pos.y
        local line = input[y]
        input[y][x] = "."
    end
    removables = {}
end

local function answer1()
    local total = 0
    for y = 1, lineHeight do
        for x = 1, lineWidth do
            local char = input[y][x]
            if char == "@" then
                if countAdjacents(x, y) then
                    total = total + 1
                end
            end
        end
    end
    return total
end

local function answer2()
    local total = 0
    while true do
        local anyRemoved = false
        for y = 1, lineHeight do
            for x = 1, lineWidth do
                local char = input[y][x]
                if char == "@" then
                    if countAdjacents(x, y) then
                        anyRemoved = true
                        total = total + 1
                    end
                end
            end
        end
        if not anyRemoved then
            break
        end
        removeMarked()
    end
    return total
end

print("The answer 1 is: " .. answer1())
print("The answer 2 is: " .. answer2())
