require "utils"

local function getInput()
    local input = readFile("11.input")
    local lines = splitString(input, lineDelimiter)
    local galaxy = {}
    local containsGalaxy = false
    local rankExpanded = {}
    local fileExpanded = {}
    for i, line in ipairs(lines) do
        containsGalaxy = false
        line = splitString(line, charDelimiter)
        for _, char in ipairs(line) do
            if char == "#" then
                containsGalaxy = true
                break
            end
        end
        table.insert(galaxy, line)
        if not containsGalaxy then
            table.insert(rankExpanded, i)
        end
    end
    for file = #galaxy[1], 1, -1 do
        containsGalaxy = false
        for rank = 1, #galaxy do
            if galaxy[rank][file] == "#" then
                containsGalaxy = true
                break
            end
        end
        if not containsGalaxy then
            table.insert(fileExpanded, file)
        end
    end

    galaxy.rankExpanded = rankExpanded
    galaxy.fileExpanded = fileExpanded
    return galaxy
end

local function isVisited(visited, pos)
    for _, value in pairs(visited) do
        if value.x == pos.x and value.y == pos.y then
            return true
        end
    end
    return false
end

local function getPath(map, from, to)
    local path = {}
    local visited = {}
    local x, y = from.x, from.y
    local toX, toY = to.x, to.y
    local newPath = false
    while true do
        newPath = true
        if toX > x and not isVisited(visited, {
            x = x + 1,
            y = y
        }) then
            x = x + 1
        elseif toX < x and not isVisited(visited, {
            x = x - 1,
            y = y
        }) then
            x = x - 1
        elseif toY > y and not isVisited(visited, {
            x = x,
            y = y + 1
        }) then
            y = y + 1
        elseif toY < y and not isVisited(visited, {
            x = x - 1,
            y = y
        }) then
            y = y - 1
        else
            newPath = false
        end
        if newPath then
            table.insert(visited, {
                x = x,
                y = y
            })
            table.insert(path, {
                x = x,
                y = y
            })
        else
            x = path[#path].x
            y = path[#path].y
            table.remove(path, #path)
        end
        if x == toX and y == toY then
            break
        end
    end
    return path
end

local function answer1(expand)
    local map = getInput()
    local galaxies = {}
    local totalPath = 0
    for y, rank in ipairs(map) do
        for x, item in ipairs(rank) do
            if item == "#" then
                table.insert(galaxies, {
                    x = x,
                    y = y
                })
            end
        end
    end
    while #galaxies > 1 do
        for i = 2, #galaxies do
            local path = getPath(galaxies, galaxies[1], galaxies[i])
            for _, val in ipairs(path) do
                totalPath = totalPath + 1
                if contains(map.fileExpanded, val.x) or contains(map.rankExpanded, val.y) then
                    totalPath = totalPath + expand
                end
            end
        end
        table.remove(galaxies, 1)
    end
    return totalPath
end
print("Parte 1:", answer1(1))
print("Parte 2:", answer1(999999))
