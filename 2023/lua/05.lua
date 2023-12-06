require "utils"

local maps = {}
local steps = {}
local seeds = {}

local function getLocation(seed)
    for _, step in ipairs(steps) do
        for _, list in ipairs(maps[step]) do
            if seed >= list.source and seed < list.source + list.range then
                -- print(step, seed, seed - list.source + list.destination)
                seed = seed - list.source + list.destination
                break
            end
        end
    end
    return seed
end

local function initMaps()
    local input = readFile("05input.txt")
    local lines = splitString(input, lineDelimiter)
    local lineTable = {}
    local actualMap = ""
    seeds = splitString(lines[1], spaceDelimiter)
    for _, line in ipairs(lines) do
        lineTable = splitString(line, spaceDelimiter)
        if #lineTable == 2 then -- step
            actualMap = lineTable[1]
            maps[actualMap] = {}
            table.insert(steps, actualMap)
        elseif #lineTable == 3 then -- list
            table.insert(maps[actualMap], {
                source = tonumber(lineTable[2]), -- Source Range Start
                destination = tonumber(lineTable[1]), -- Destination Range Start
                range = tonumber(lineTable[3]) -- Range length
            })
        end
    end
end

local function answer1()
    local bestLocation = 999999999999 -- el numero mas alto posible?
    local location = 0
    for i = 2, #seeds do
        location = getLocation(tonumber(seeds[i]))
        if bestLocation > location then
            bestLocation = location
        end
    end
    return bestLocation
end
-- 2768526595 esto es muy alto
-- 401658854 esto es muy alto
-- 401662100 esto es muy alto
-- 401658582 esta no es pero debo estar cerca
-- 23846357 esta no es correcta
-- 20191103 no es correcta
local function answer2()
    local bestLocation = 999999999999 -- el numero mas alto posible?
    local location = 0
    local i = 2
    local seed = 0
    local interval = 65536
    local actualSeed = 0
    local leftInterval = 0
    local rightInterval = 0
    local maxLength = 0
    while i < #seeds do
        interval = 262144 -- tested with 131072, 65536, 4096, 2048, 1024
        seed = tonumber(seeds[i])
        actualSeed = seed
        maxLength = seed + tonumber(seeds[i + 1])
        leftInterval = 0
        rightInterval = 0
        while true do
            if actualSeed >= maxLength then
                interval = math.floor(interval / 2)
                if interval == 0 or (leftInterval == 0 and rightInterval == 0) then
                    break
                end
                actualSeed = leftInterval
                maxLength = rightInterval
            else
                location = getLocation(actualSeed)
                if bestLocation > location then
                    -- print(location, bestLocation, interval, leftInterval, rightInterval)
                    bestLocation = location
                    leftInterval = actualSeed - interval
                    rightInterval = actualSeed
                end
                actualSeed = actualSeed + interval
            end

        end
        -- print(seeds[i], "------------------------")
        i = i + 2
    end
    return bestLocation
end

initMaps()
print("Parte 1:", answer1())
print("Parte 2:", answer2())
