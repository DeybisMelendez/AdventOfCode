local aoc = require "lib.aoc"

local function getInput()
    local input = aoc.input.getInput()
    input = aoc.string.split(input, "\n")
    for i = 1, #input do
        input[i] = aoc.string.splitToChar(input[i])
    end
    return input
end

local function answer1()
    local input = getInput()
    local total = 0
    for y = 1, #input - 1 do
        for x = 2, #input[y] - 1 do
            local char = input[y][x]
            if char == "S" and input[y + 1][x] == "." then
                input[y + 1][x] = "|"
            elseif char == "|" then
                if input[y + 1][x] == "^" then
                    input[y + 1][x - 1] = "|"
                    input[y + 1][x + 1] = "|"
                    total = total + 1
                elseif input[y + 1][x] == "." then
                    input[y + 1][x] = "|"
                end
            end
        end
    end
    return total
end

local function answer2()
    local input = getInput()
    local H = #input
    local W = #input[1]

    local ways = {}
    for y = 1, H do
        ways[y] = {}
        for x = 1, W do
            ways[y][x] = 0
        end
    end

    local total = 0

    for y = 1, H do
        for x = 1, W do
            local char = input[y][x]
            if char == "S" then
                ways[y][x] = 1
            elseif char == "." and y > 1 then
                ways[y][x] = ways[y][x] + ways[y - 1][x]
            elseif char == "^" then
                if x > 1 then
                    ways[y][x - 1] = ways[y][x - 1] + ways[y - 1][x]
                else
                    total = total + ways[y][x]
                end
                if x < W then
                    ways[y][x + 1] = ways[y][x + 1] + ways[y - 1][x]
                else
                    total = total + ways[y][x]
                end
            end
            if y == H then
                total = total + ways[y][x]
            end
        end
    end

    return total
end

print("answer 1 is " .. answer1())
print(string.format("Answer 2: %18.0f", answer2()))
