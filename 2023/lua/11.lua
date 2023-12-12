require "utils"

local function getInput()
    local input = readFile("11.input")
    local lines = splitString(input, lineDelimiter)
    local map = {}
    local containsGalaxy = false
    local rankExpanded = {}
    local fileExpanded = {}
    local galaxies = {}

    for i, line in ipairs(lines) do
        containsGalaxy = false
        line = splitString(line, charDelimiter)
        for j, char in ipairs(line) do
            if char == "#" then
                containsGalaxy = true
                table.insert(galaxies, {
                    x = j,
                    y = i
                })
            end
        end
        table.insert(map, line)
        if not containsGalaxy then
            table.insert(rankExpanded, i)
        end
    end
    for file = 1, #map[1] do
        containsGalaxy = false
        for rank = 1, #map do
            if map[rank][file] == "#" then
                containsGalaxy = true
                break
            end
        end
        if not containsGalaxy then
            table.insert(fileExpanded, file)
        end
    end

    return galaxies, rankExpanded, fileExpanded
end

local function answer1(expand)
    local galaxies, rankExpanded, fileExpanded = getInput()
    local totalPath = 0
    while #galaxies > 1 do
        for i = 2, #galaxies do
            totalPath = totalPath + math.abs(galaxies[1].x - galaxies[i].x) + math.abs(galaxies[1].y - galaxies[i].y)
            for _, val in ipairs(fileExpanded) do
                if (galaxies[i].x > val and galaxies[1].x < val) or (galaxies[i].x < val and galaxies[1].x > val) then
                    totalPath = totalPath + expand
                end
            end
            for _, val in ipairs(rankExpanded) do
                if (galaxies[i].y > val and galaxies[1].y < val) or (galaxies[i].y > val and galaxies[1].y < val) then
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
