require "utils"

local maps = {}
local steps = {}
local seeds = {}

local function getLocation(seed)
    local originalSeed = seed
    for _, step in ipairs(steps) do
        for _, list in ipairs(maps[step]) do
            if seed >= list.source and seed <= list.source + list.range then
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

initMaps()
print("Parte 1:", answer1())
