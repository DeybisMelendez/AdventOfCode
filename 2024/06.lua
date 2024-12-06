local aoc = require "lib.aoc"

local memoPos = {}
local input = aoc.input.getInput()
local guard = {}
local positions = {}
local UP, RIGHT, DOWN, LEFT = 1, 2, 3, 4
input = aoc.string.split(input, "\n")

for y, line in ipairs(input) do
    input[y] = aoc.string.splitToChar(line)
    if not guard.x then
        for x, char in ipairs(input[y]) do
            if char == "^" then
                guard = {
                    x = x,
                    y = y,
                    dir = UP
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
    if self.dir == UP then
        if self.y > 1 then
            if input[self.y - 1][self.x] == "#" then
                self.dir = RIGHT
                return true
            end
            self.y = self.y - 1
            return true
        end
        return false
    end
    if self.dir == RIGHT then
        if self.x < width then
            if input[self.y][self.x + 1] == "#" then
                self.dir = DOWN
                return true
            end
            self.x = self.x + 1
            return true
        end
        return false
    end
    if self.dir == DOWN then
        if self.y < height then
            if input[self.y + 1][self.x] == "#" then
                self.dir = LEFT
                return true
            end
            self.y = self.y + 1
            return true
        end
        return false
    end
    if self.dir == LEFT then
        if self.x > 1 then
            if input[self.y][self.x - 1] == "#" then
                self.dir = UP
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
    memoPos[guard.x + guard.y * 1000] = true
    while guard:nextPos() do
        local memoKey = guard.x + guard.y * 1000
        if not memoPos[memoKey] then
            total = total + 1
            memoPos[memoKey] = true
            table.insert(positions, { x = guard.x, y = guard.y })
        end
    end
    return total
end

local function answer2()
    local total = 0
    for _, pos in ipairs(positions) do
        if input[pos.y][pos.x] ~= "#" then
            local backup = input[pos.y][pos.x]
            input[pos.y][pos.x] = "#"
            guard.x, guard.y, guard.dir = guardX, guardY, guardDir
            memoPos = {}
            memoPos[guard.x + guard.y * 1000 + guard.dir * 1000000] = true
            while guard:nextPos() do
                local memoKey = guard.x + guard.y * 1000 + guard.dir * 1000000
                if not memoPos[memoKey] then
                    memoPos[memoKey] = true
                else
                    total = total + 1
                    input[pos.y][pos.x] = backup
                    break
                end
            end
            input[pos.y][pos.x] = backup
        end
    end
    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
