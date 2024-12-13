local aoc = require "lib.aoc"
local clawMachines = {}
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")
for i = 1, #input, 3 do
    local clawMachine = {
        a = {
            x = tonumber(input[i]:match("X%+(%d+)")),
            y = tonumber(input[i + 1]:match("X%+(%d+)")),
            z = tonumber(input[i + 2]:match("X%=(%d+)")),
        },
        b = {
            x = tonumber(input[i]:match("Y%+(%d+)")),
            y = tonumber(input[i + 1]:match("Y%+(%d+)")),
            z = tonumber(input[i + 2]:match("Y%=(%d+)")),
        },
    }
    table.insert(clawMachines, clawMachine)
end

local function getTotalTokens()
    local total = 0
    for _, clawMachine in ipairs(clawMachines) do
        local mul1 = clawMachine.a.x
        local mul2 = -clawMachine.b.x
        local x1 = clawMachine.a.x * mul2
        local y1 = clawMachine.a.y * mul2
        local z1 = clawMachine.a.z * mul2

        --local x2 = clawMachine.b.x * mul1
        local y2 = clawMachine.b.y * mul1
        local z2 = clawMachine.b.z * mul1

        local y = (z1 + z2) / (y1 + y2)
        local x = (z1 - y1 * y) / x1
        if x == math.floor(x) and y == math.floor(y) then
            total = total + x * 3 + y
        end
    end
    return total
end

local function answer1()
    return getTotalTokens()
end

local function answer2()
    for i = 1, #clawMachines do
        clawMachines[i].a.z = clawMachines[i].a.z + 10000000000000
        clawMachines[i].b.z = clawMachines[i].b.z + 10000000000000
    end
    return getTotalTokens()
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
