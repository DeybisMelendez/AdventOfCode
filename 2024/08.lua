local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    input[i] = aoc.string.splitToChar(line)
end

local function isValidPosition(x, y)
    return x > 0 and y > 0 and x <= #input and y <= #input[x]
end

local function addAntinodes(antinodes, x1, y1, x2, y2, inf)
    local dx, dy = x2 - x1, y2 - y1
    local x, y = x1 - dx, y1 - dy
    if isValidPosition(x, y) then
        local key1 = x .. "-" .. y
        antinodes[key1] = true
        if inf then
            addAntinodes(antinodes, x2, y2, x, y, inf)
        end
    end
    if inf then
        x, y = x2 + dx, y2 + dy
        if isValidPosition(x2, y2) then
            local key2 = x2 .. "-" .. y2
            antinodes[key2] = true
            addAntinodes(antinodes, x2, y2, x, y, inf)
        end
    else
        x, y = x2 + dx, y2 + dy
        if isValidPosition(x, y) then
            local key2 = x .. "-" .. y
            antinodes[key2] = true
        end
    end
end

local function getAntennas()
    local antennas = {}
    for i = 1, #input do
        for j = 1, #input[i] do
            local char = input[i][j]
            if char ~= "." then
                antennas[char] = antennas[char] or {}
                table.insert(antennas[char], { i, j })
            end
        end
    end
    return antennas
end
local function answer1()
    local antennas = getAntennas()
    local antinodes = {}
    for _, positions in pairs(antennas) do
        if #positions > 1 then
            for i = 1, #positions do
                local x1, y1 = positions[i][1], positions[i][2]
                for j = i + 1, #positions do
                    local x2, y2 = positions[j][1], positions[j][2]
                    addAntinodes(antinodes, x1, y1, x2, y2, false)
                end
            end
        end
    end

    return #aoc.dict.getKeys(antinodes)
end

local function answer2()
    local antennas = getAntennas()
    local antinodes = {}
    for _, positions in pairs(antennas) do
        if #positions > 1 then
            for i = 1, #positions do
                local x1, y1 = positions[i][1], positions[i][2]
                for j = i + 1, #positions do
                    local x2, y2 = positions[j][1], positions[j][2]
                    addAntinodes(antinodes, x1, y1, x2, y2, true)
                end
            end
        end
    end

    return #aoc.dict.getKeys(antinodes)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
