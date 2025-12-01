local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

local function answer1()
    local dial = 50
    local solution = 0
    for i, line in ipairs(input) do
        local dir = line:sub(1,1)
        local steps = tonumber(line:sub(2, #line))
        if steps > 100 then
            steps = steps % 100
            solution = solution + math.floor(steps / 100)
        end
        if dir == "R" then
            dial = dial + steps
        else
            dial = dial - steps
        end
        if dial < 0 then
            dial = dial + 100
        end
        if dial > 99 then
            dial = dial - 100
        end
        if dial == 0 then
            solution = solution + 1
        end
    end
    return solution
end

local function answer2()
    
end

print("answer 1 is " .. answer1())