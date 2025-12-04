local aoc = require "lib.aoc"
local input = aoc.input.getInput()
for char=1, #input do
    if input:sub(char, char) == "." then
        input = input:sub(1, char-1) .. " " .. input:sub(char+1)
    end
end

input = aoc.string.split(input, "\n")
local lineHeight = #input
local lineWidth = #input[1]
local asciiBrightness = "@%#*+=-:. "
local removables = {}

local function printGrid()
    for y = 1, lineHeight do
        print(input[y])
    end
end

local function getNextAsciiIndex(char)
    for i = 1, #asciiBrightness do
        if asciiBrightness:sub(i, i) == char then
            return i < #asciiBrightness and i + 1 or i
        end
    end
    return #asciiBrightness
end

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
        local char = input[y]:sub(x, x)
        local nexCharIndex = getNextAsciiIndex(char)
        local nexChar = asciiBrightness:sub(nexCharIndex, nexCharIndex)
        input[y] = line:sub(1, x-1) .. nexChar.. line:sub(x+1)
    end
    --removables = {}
end

local function visualization()
    os.execute("clear")
    printGrid()
    os.execute("sleep 1")
    while true do
        local anyRemoved = false
        for y = 1, lineHeight do
            for x = 1, lineWidth do
                local char = input[y]:sub(x, x)
                if char == "@" then
                    if countAdjacents(x, y) then
                        anyRemoved = true
                    end
                end
            end
        end
        if not anyRemoved then
            break
        end
        removeMarked()
        os.execute("clear")
        printGrid()
        os.execute("sleep 0.2")
    end
end

--visualization()
print(lineHeight, lineWidth)