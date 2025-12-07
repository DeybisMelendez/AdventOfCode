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
    -- os.execute("clear")
    for y = 1, #input do
        local line = ""
        for x = 1, #input[y] do
            line = line .. input[y][x]
        end
        print(line)
    end
    print("------------")
    os.execute("sleep 0.01")
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
    local result = 0
    if char == "S" and input[y + 1][x] == "." then
        input[y + 1][x] = "|"
        -- printMap(input)
        result = nextChar(y, x + 1, input)
        input[y + 1][x] = "."
    elseif char == "|" then
        if input[y + 1][x] == "^" then
            input[y + 1][x - 1] = "|"
            -- printMap(input)
            result = nextChar(y, x + 1, input)
            input[y + 1][x - 1] = "."
            input[y + 1][x + 1] = "|"
            -- printMap(input)
            result = result + nextChar(y, x + 1, input)
            input[y + 1][x + 1] = "."
        elseif input[y + 1][x] == "." then
            input[y + 1][x] = "|"
            -- printMap(input)
            result = nextChar(y, x + 1, input)
            input[y + 1][x] = "."
        end
    end

    return result
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

local function answer2bak()
    local input = getInput()
    return nextChar(1, 2, input)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
