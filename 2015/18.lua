local aoc = require "lib.aoc"

local function getInput()
    local input = aoc.input.getInput()
    input = aoc.string.split(input, "\n")
    for i, line in ipairs(input) do
        input[i] = aoc.string.splitToChar(line)
    end
    return input
end

local function countNeighbors(x, y, gen)
    local neighbors = 0
    local len = #gen
    if x > 1 and gen[x - 1][y] == "#" then
        neighbors = neighbors + 1
    end
    if x > 1 and y > 1 and gen[x - 1][y - 1] == "#" then
        neighbors = neighbors + 1
    end
    if x > 1 and y < len and gen[x - 1][y + 1] == "#" then
        neighbors = neighbors + 1
    end
    if y > 1 and gen[x][y - 1] == "#" then
        neighbors = neighbors + 1
    end
    if y < len and gen[x][y + 1] == "#" then
        neighbors = neighbors + 1
    end
    if x < len and gen[x + 1][y] == "#" then
        neighbors = neighbors + 1
    end
    if x < len and y < len and gen[x + 1][y + 1] == "#" then
        neighbors = neighbors + 1
    end
    if x < len and y > 1 and gen[x + 1][y - 1] == "#" then
        neighbors = neighbors + 1
    end
    return neighbors
end

local function nextGeneration(gen, cornerOn)
    local newGeneration = {}
    for x, row in ipairs(gen) do
        table.insert(newGeneration, {})
        for y, light in ipairs(row) do
            local neighbors = countNeighbors(x, y, gen)
            if light == "#" and (neighbors == 3 or neighbors == 2) then
                table.insert(newGeneration[x], "#")
            elseif light == "." and neighbors == 3 then
                table.insert(newGeneration[x], "#")
            else
                table.insert(newGeneration[x], ".")
            end
        end
    end
    if cornerOn then
        newGeneration[1][1] = "#"
        newGeneration[#gen][1] = "#"
        newGeneration[1][#gen] = "#"
        newGeneration[#gen][#gen] = "#"
    end
    return newGeneration
end

local function countLights(gen)
    local lights = 0
    for _, row in ipairs(gen) do
        for _, light in ipairs(row) do
            if light == "#" then
                lights = lights + 1
            end
        end
    end
    return lights
end

local function answer1()
    local gen = getInput()
    for _ = 1, 100 do
        gen = nextGeneration(gen, false)
    end
    return countLights(gen)
end

local function answer2()
    local gen = getInput()
    gen[1][1] = "#"
    gen[#gen][1] = "#"
    gen[1][#gen] = "#"
    gen[#gen][#gen] = "#"
    for _ = 1, 100 do
        gen = nextGeneration(gen, true)
    end
    return countLights(gen)
end

print("answer 1 is " .. answer1())
print("answer 1 is " .. answer2())
