local aoc = require "lib.aoc"

local input = aoc.input.getInput("input.txt")
input = string.gsub(input, "turn on", "turn_on")
input = string.gsub(input, "turn off", "turn_off")
input = string.gsub(input, "through ", "")
input = string.gsub(input, ",", " ")

input = aoc.string.split(input, "\n")

local function answer1()
    local grid = {}
    for y = 0, 999 do
        grid[y] = {}
        for x = 0, 999 do
            grid[y][x] = 0
        end
    end
    for _, ins in ipairs(input) do
        ins = aoc.string.split(ins, "%s")
        local y1, x1, y2, x2 = tonumber(ins[2]), tonumber(ins[3]), tonumber(ins[4]), tonumber(ins[5])
        if ins[1] == "turn_on" then
            for y = y1, y2 do
                for x = x1, x2 do
                    grid[y][x] = 1
                end
            end
        elseif ins[1] == "turn_off" then
            for y = y1, y2 do
                for x = x1, x2 do
                    grid[y][x] = 0
                end
            end
        elseif ins[1] == "toggle" then
            for y = y1, y2 do
                for x = x1, x2 do
                    if grid[y][x] == 0 then
                        grid[y][x] = 1
                    else
                        grid[y][x] = 0
                    end
                end
            end
        end
    end
    local count = 0
    for y = 0, #grid do
        for x = 0, #grid[y] do
            if grid[y][x] == 1 then
                count = count + 1
            end
        end
    end
    return count
end

local function answer2()
    local grid = {}
    for y = 0, 999 do
        grid[y] = {}
        for x = 0, 999 do
            grid[y][x] = 0
        end
    end
    for _, ins in ipairs(input) do
        ins = aoc.string.split(ins, "%s")
        local y1, x1, y2, x2 = tonumber(ins[2]), tonumber(ins[3]), tonumber(ins[4]), tonumber(ins[5])
        if ins[1] == "turn_on" then
            for y = y1, y2 do
                for x = x1, x2 do
                    grid[y][x] = grid[y][x] + 1
                end
            end
        elseif ins[1] == "turn_off" then
            for y = y1, y2 do
                for x = x1, x2 do
                    grid[y][x] = grid[y][x] - 1
                    if grid[y][x] < 0 then grid[y][x] = 0 end
                end
            end
        elseif ins[1] == "toggle" then
            for y = y1, y2 do
                for x = x1, x2 do
                    grid[y][x] = grid[y][x] + 2
                end
            end
        end
    end
    local count = 0
    for y = 0, #grid do
        for x = 0, #grid[y] do
            if grid[y][x] > 0 then
                count = count + grid[y][x]
            end
        end
    end
    return count
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
