local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

local function answer1()
    local dial = 50
    local solution = 0
    for _, line in ipairs(input) do
        local dir = line:sub(1, 1)
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
    local dial = 50
    local solution = 0
    for _, line in ipairs(input) do
        local dir = line:sub(1, 1)
        local steps = tonumber(line:sub(2, #line))
        local count = 0
        local initialDial = dial
        if steps > 100 then
            count = math.floor(steps / 100)
            steps = steps % 100
        end
        if dir == "R" then
            dial = dial + steps
        else
            dial = dial - steps
        end
        if dial == 0 then
            count = count + 1
        end
        if dial < 0 then
            dial = dial + 100
            if initialDial > 0 then
                count = count + 1
            end
        elseif dial > 99 then
            dial = dial - 100
            count = count + 1
        end

        solution = solution + count
    end
    return solution
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
