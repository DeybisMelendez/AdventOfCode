require "utils"

local text = string.readFile("day14input.txt")

text = text:gsub("can fly ", "")
text = text:gsub("km/s for ", "")
text = text:gsub("seconds, but then must rest for ", "")
text = text:gsub(" seconds.", "")
local split = string.split(text, "[^\n]+")
local input = {}
for _,v in pairs(split) do
    v = string.split(v, "[^%s]+")
    local index = v[1]
    table.remove(v,1)
    input[index] = {speed = tonumber(v[1]), time = tonumber(v[2]),
            sleep = tonumber(v[3]), sleeping = false,
            timeLeft = tonumber(v[2]), sleepLeft = 0, distance = 0,
            points = 0}
end

local function step(t)
    for i,v in pairs(t) do
        if v.sleeping then
            t[i].sleepLeft = v.sleepLeft - 1
            if v.sleepLeft == 0 then
                t[i].sleeping = false
                t[i].timeLeft = v.time
            end
        else
            t[i].timeLeft = v.timeLeft - 1
            t[i].distance = v.distance + v.speed
            if v.timeLeft == 0 then
                t[i].sleeping = true
                t[i].sleepLeft = v.sleep
            end
        end
    end
    return t
end

local function stepPoints(t)
    local maxDistance = 0
    local winners = {}
    for i,v in pairs(t) do
        if v.distance > maxDistance then
            maxDistance = v.distance
            winners = {}
            table.insert(winners,i)
        elseif v.distance == maxDistance then
            table.insert(winners, i)
        end
    end
    for i,v in pairs(winners) do
        t[v].points = t[v].points + 1
    end
    return t
end

local function getMaxDistance(t)
    local max = 0
    for i,v in pairs(t) do
        if v.distance > max then
            max = v.distance
        end
    end
    return max
end

local function getMaxPoints(t)
    local max = 0
    for i,v in pairs(t) do
        if v.points > max then
            max = v.points
        end
        print(i,v.points)
    end
    return max
end

local function answer1(t)
    for _=1, 1000 do
        t = step(t)
    end
    return getMaxDistance(t)
end

local function answer2(t)
    for _=1, 140 do
        --t = stepPoints(t)
        t = step(t)
        t = stepPoints(t)
    end
    return getMaxPoints(t)
end

print(answer1(table.copy(input)))
print(answer2(table.copy(input)))