local aoc = require "lib.aoc"

local function getInput()
    local input = aoc.input.getInput()
    input = aoc.string.split(input, "\n")
    for i = 1, #input do
        input[i] = aoc.string.splitToChar(input[i])
    end
    return input
end

local function printMap(input)
    os.execute("clear")
    for y = 1, #input do
        local line = ""
        for x = 1, #input[y] do
            line = line .. input[y][x]
        end
        print(line)
    end
    os.execute("sleep 0.05")
end

local function nextChar(y, x, input)
    local char = input[y][x]

    while true do
        if x == #input[y] then
            x = 1
            y = y + 1
        end
        if y == #input then
            return 1
        end
        char = input[y][x]
        if char ~= "." and char ~= "^" then
            break
        end
        x = x + 1

    end
    if char == "S" and input[y + 1][x] == "." then
        input[y + 1][x] = "|"
        printMap(input)
        nextChar(y, x + 1, input)
        input[y + 1][x] = "."
    elseif char == "|" then
        if input[y + 1][x] == "^" then
            input[y + 1][x - 1] = "|"
            printMap(input)
            nextChar(y, x + 1, input)
            input[y + 1][x - 1] = "."
            input[y + 1][x + 1] = "|"
            printMap(input)
            nextChar(y, x + 1, input)
            input[y + 1][x + 1] = "."
        elseif input[y + 1][x] == "." then
            input[y + 1][x] = "|"
            printMap(input)
            nextChar(y, x + 1, input)
            input[y + 1][x] = "."
        end
    end
end

local input = getInput()
nextChar(1, 2, input)
