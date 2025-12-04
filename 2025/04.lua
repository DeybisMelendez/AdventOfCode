local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
local lineHeight = #input
local lineWidth = #input[1]

local removables = {}

local function countAdjacents(x, y)
    local deltas = {
        {-1, -1}, {0, -1}, {1, -1},
        {-1, 0},           {1, 0},
        {-1, 1},  {0, 1},  {1, 1},
    }
    local count = 0
    for _, delta in ipairs(deltas) do
        local dx, dy = delta[1], delta[2]
        local nx, ny = x + dx, y + dy
        if nx >= 1 and nx <= lineWidth and ny >= 1 and ny <= lineHeight then
            if input[ny]:sub(nx, nx) == "@" then
                count = count + 1
            end
        end
    end
    if count < 4 then
        table.insert(removables, {x = x, y = y})
        return true
    end
    return false
end

local function removeMarked()
    for _, pos in ipairs(removables) do
        local x, y = pos.x, pos.y
        local line = input[y]
        input[y] = line:sub(1, x-1) .. "." .. line:sub(x+1)
    end
    removables = {}
end


local function answer1()
    local total = 0
    for y = 1, lineHeight do
        for x = 1, lineWidth do
            local char = input[y]:sub(x, x)
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
                local char = input[y]:sub(x, x)
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