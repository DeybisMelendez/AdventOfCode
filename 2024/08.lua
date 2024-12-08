local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i, line in ipairs(input) do
    input[i] = aoc.string.splitToChar(line)
end

local function isValidPosition(x, y)
    return x > 0 and y > 0 and x <= #input and y <= #input[x]
end

local function answer1()
    local antinodes = {}
    for i = 1, #input do
        for j = 1, #input[i] do
            local char = input[i][j]
            if char ~= "." then
                for i2 = 1, #input do
                    for j2 = 1, #input[i2] do
                        local char2 = input[i2][j2]
                        if char == char2 and (i ~= i2 or j ~= j2) then
                            -- Distancia entre antenas
                            local di, dj = i2 - i, j2 - j

                            -- Calcular antinodo 1
                            local x1, y1 = i - di, j - dj
                            if isValidPosition(x1, y1) then
                                local key1 = x1 .. "-" .. y1
                                antinodes[key1] = true
                            end

                            -- Calcular antinodo 2
                            local x2, y2 = i2 + di, j2 + dj
                            if isValidPosition(x2, y2) then
                                local key2 = x2 .. "-" .. y2
                                antinodes[key2] = true
                            end
                        end
                    end
                end
            end
        end
    end
    return #aoc.dict.getKeys(antinodes)
end

local function addAntinodes(antinodes, x1, y1, x2, y2)
    local dx, dy = x2 - x1, y2 - y1
    local x, y = x1 - dx, y1 - dy
    if isValidPosition(x, y) then
        local key1 = x .. "-" .. y
        antinodes[key1] = true
        addAntinodes(antinodes, x2, y2, x, y)
    end
    x, y = x2 + dx, y2 + dy
    if isValidPosition(x2, y2) then
        local key2 = x2 .. "-" .. y2
        antinodes[key2] = true
        addAntinodes(antinodes, x2, y2, x, y)
    end
end

local function answer2()
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

    local antinodes = {}
    for _, positions in pairs(antennas) do
        if #positions > 1 then
            for i = 1, #positions do
                local x1, y1 = positions[i][1], positions[i][2]
                for j = i + 1, #positions do
                    local x2, y2 = positions[j][1], positions[j][2]
                    addAntinodes(antinodes, x1, y1, x2, y2)
                end
            end
        end
    end

    return #aoc.dict.getKeys(antinodes)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
