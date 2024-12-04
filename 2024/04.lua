local aoc = require "lib.aoc"

local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    input[i] = aoc.string.splitToChar(line)
end
local XMAS = { "X", "M", "A", "S" }
local height = #input
local width = #input[1]
local directions = {
    { 1,  0 },  -- derecha
    { 1,  1 },  -- diagonal derecha abajo
    { 1,  -1 }, -- diagonal derecha arriba
    { 0,  1 },  -- abajo
    { 0,  -1 }, -- arriba
    { -1, 0 },  -- izquierda
    { -1, 1 },  -- diagonal izquierda abajo
    { -1, -1 }, -- diagonal izquierda arriba
}
-- Función genérica para verificar un patrón
local function matchesPattern(x, y, dx, dy)
    for i, char in ipairs(XMAS) do
        local nx, ny = x + (i - 1) * dx, y + (i - 1) * dy
        if nx < 1 or ny < 1 or nx > width or ny > height or input[nx][ny] ~= char then
            return false
        end
    end
    return true
end

local function countXMAS(x, y)
    local count = 0
    for _, dir in ipairs(directions) do
        if matchesPattern(x, y, dir[1], dir[2]) then
            count = count + 1
        end
    end
    return count
end

local function isValidXMAS(x, y)
    return (input[x - 1][y - 1] == "M" and input[x + 1][y + 1] == "S") or
        (input[x - 1][y - 1] == "S" and input[x + 1][y + 1] == "M") or
        (input[x + 1][y - 1] == "M" and input[x - 1][y + 1] == "S") or
        (input[x + 1][y - 1] == "S" and input[x - 1][y + 1] == "M")
end

local function answer1()
    local totalXMAS = 0
    for y = 1, height do
        for x = 1, width do
            if input[x][y] == "X" then
                totalXMAS = totalXMAS + countXMAS(x, y)
            end
        end
    end
    return totalXMAS
end

local function answer2()
    local totalXMAS = 0
    for y = 2, height - 1 do
        for x = 2, width - 1 do
            if input[x][y] == "A" and isValidXMAS(x, y) then
                totalXMAS = totalXMAS + 1
            end
        end
    end
    return totalXMAS
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
