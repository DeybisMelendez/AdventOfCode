local aoc = require "lib.aoc"

local input = aoc.string.split(aoc.input.getInput(), ",%s")

local dirs = {
    ["north"] = { x = 0, y = 1 },
    ["east"] = { x = 1, y = 0 },
    ["south"] = { x = 0, y = -1 },
    ["west"] = { x = -1, y = 0 }
}
local map = {}
local function turnRight(person)
    if person.dir == "north" then
        person.dir = "east"
    elseif person.dir == "east" then
        person.dir = "south"
    elseif person.dir == "south" then
        person.dir = "west"
    elseif person.dir == "west" then
        person.dir = "north"
    end
end

local function turnLeft(person)
    if person.dir == "north" then
        person.dir = "west"
    elseif person.dir == "west" then
        person.dir = "south"
    elseif person.dir == "south" then
        person.dir = "east"
    elseif person.dir == "east" then
        person.dir = "north"
    end
end

local function getDistance(person)
    return math.abs(person.x) + math.abs(person.y)
end

local function answer1()
    local me = { x = 0, y = 0, dir = "north" }
    for i = 1, #input do
        local dir = string.sub(input[i], 1, 1)
        local num = tonumber(string.sub(input[i], 2))
        if dir == "R" then
            turnRight(me)
        elseif dir == "L" then
            turnLeft(me)
        end
        me.x = me.x + dirs[me.dir].x * num
        me.y = me.y + dirs[me.dir].y * num
    end
    return getDistance(me)
end

local function answer2()
    local visited = {}
    local me = { x = 0, y = 0, dir = "north" }
    for i = 1, #input do
        local dir = string.sub(input[i], 1, 1)
        local num = tonumber(string.sub(input[i], 2))
        if dir == "R" then
            turnRight(me)
        elseif dir == "L" then
            turnLeft(me)
        end
        for step = 1, num do
            me.x = me.x + dirs[me.dir].x
            me.y = me.y + dirs[me.dir].y
            local posKey = me.x .. "," .. me.y
            if visited[posKey] then
                return getDistance(me)
            else
                visited[posKey] = true
            end
        end
    end
end
answer1()
