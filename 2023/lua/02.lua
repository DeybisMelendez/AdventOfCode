require "utils" -- utils.lua

local function answer1()
    local maxCubeColors = {
        blue = 14,
        green = 13,
        red = 12
    }
    local input = readFile("02input.txt")
    local lines = splitString(input, lineDelimiter)
    local game = ""
    local gameNumber = 0
    local sets = {}
    local cubes = {}
    local cube = {}
    local cubeNumber = 0
    local cubeColor = ""
    local isSetVerified = true
    local result = 0

    for _, line in ipairs(lines) do
        game = splitString(line, colonDelimiter)
        gameNumber = tonumber(string.sub(game[1], 5, -1))
        sets = splitString(game[2], semiColonDelimiter)
        for _, set in ipairs(sets) do
            isSetVerified = true
            cubes = splitString(set, commaDelimiter)
            for _, cubeCount in ipairs(cubes) do
                cube = splitString(cubeCount, spaceDelimiter)
                cubeNumber = tonumber(cube[1])
                cubeColor = cube[2]
                if cubeNumber > maxCubeColors[cubeColor] then
                    isSetVerified = false
                    break
                end
            end
            if not isSetVerified then
                break
            end
        end
        if isSetVerified then
            result = result + gameNumber
        end
    end
    return result
end

local function answer2()
    local input = readFile("02input.txt")
    local lines = splitString(input, lineDelimiter)
    local game = ""
    local sets = {}
    local cubes = {}
    local cube = {}
    local cubeNumber = 0
    local cubeColor = ""
    local minCube = {
        blue = 0,
        red = 0,
        green = 0
    }
    local result = 0

    for _, line in ipairs(lines) do
        game = splitString(line, colonDelimiter)
        sets = splitString(game[2], semiColonDelimiter)
        minCube.blue = 0
        minCube.red = 0
        minCube.green = 0
        for _, set in ipairs(sets) do
            cubes = splitString(set, commaDelimiter)
            for _, cubeCount in ipairs(cubes) do
                cube = splitString(cubeCount, spaceDelimiter)
                cubeNumber = tonumber(cube[1])
                cubeColor = cube[2]
                if cubeNumber > minCube[cubeColor] then
                    minCube[cubeColor] = cubeNumber
                end
            end
        end
        result = result + minCube.blue * minCube.red * minCube.green
    end
    return result
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
