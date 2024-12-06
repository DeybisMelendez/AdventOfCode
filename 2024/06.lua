local aoc = require "lib.aoc"

local memoPos = {}
local input = aoc.input.getInput()
local guard = {}
input = aoc.string.split(input, "\n")
for y, line in ipairs(input) do
    input[y] = aoc.string.splitToChar(line)
    if not guard.x then
        for x, char in ipairs(input[y]) do
            if char == "^" then
                guard = {
                    x = x,
                    y = y,
                    dir = "UP"
                }
                input[y][x] = "."
                break
            end
        end
    end
end
local guardX, guardY, guardDir = guard.x, guard.y, guard.dir
local width = #input
local height = #input[1]

function guard:nextPos()
    if self.dir == "UP" then
        if self.y > 1 then
            if input[self.y - 1][self.x] == "#" then
                self.dir = "RIGHT"
                return true
            end
            self.y = self.y - 1
            return true
        end
        return false
    end
    if self.dir == "RIGHT" then
        if self.x < width then
            if input[self.y][self.x + 1] == "#" then
                self.dir = "DOWN"
                return true
            end
            self.x = self.x + 1
            return true
        end
        return false
    end
    if self.dir == "DOWN" then
        if self.y < height then
            if input[self.y + 1][self.x] == "#" then
                self.dir = "LEFT"
                return true
            end
            self.y = self.y + 1
            return true
        end
        return false
    end
    if self.dir == "LEFT" then
        if self.x > 1 then
            if input[self.y][self.x - 1] == "#" then
                self.dir = "UP"
                return true
            end
            self.x = self.x - 1
            return true
        end
        return false
    end
end

local function answer1()
    memoPos = {}
    guard.x, guard.y, guard.dir = guardX, guardY, guardDir
    local total = 1
    memoPos[guard.x .. "-" .. guard.y] = true
    while guard:nextPos() do
        if not memoPos[guard.x .. "-" .. guard.y] then
            total = total + 1
            memoPos[guard.x .. "-" .. guard.y] = true
        end
    end
    return total
end
local function answer2()
    local total = 0
    for y = 1, #input do
        for x = 1, #input[1] do
            if input[y][x] ~= "#" then
                local backup = input[y][x]
                input[y][x] = "#"
                guard.x, guard.y, guard.dir = guardX, guardY, guardDir
                memoPos = {}
                memoPos[guard.x .. "-" .. guard.y .. guard.dir] = true
                while guard:nextPos() do
                    if not memoPos[guard.x .. "-" .. guard.y .. "-" .. guard.dir] then
                        memoPos[guard.x .. "-" .. guard.y .. "-" .. guard.dir] = true
                    else
                        total = total + 1
                        input[y][x] = backup
                        break
                    end
                end
                input[y][x] = backup
            end
        end
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
