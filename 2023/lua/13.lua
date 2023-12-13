require "utils"

local IS_HORIZONTAL<const> = true
local IS_VERTICAL<const> = false

local function getInput()
    local input = readFile("13.input"):gsub("\n\n", "\n,\n")

    local maps = {}
    for i, map in ipairs(splitString(input, commaDelimiter)) do
        map = splitString(map, lineDelimiter)
        maps[i] = {}
        for j, line in ipairs(map) do
            maps[i][j] = splitString(line, charDelimiter)
        end
    end
    return maps
end

local function checkHorizontal(map, up, down)
    if up < 1 then
        return true
    end
    if down > #map then
        if up == down - 1 then
            return false
        end
        return true
    end
    for i = 1, #map[up] do
        if map[up][i] ~= map[down][i] then
            return false
        end
    end
    return checkHorizontal(map, up - 1, down + 1)
end

local function checkVertical(map, left, right)
    if left < 1 then
        return true
    end
    if right > #map[1] then
        if left == right - 1 then
            return false
        end
        return true
    end
    for i = 1, #map do
        if map[i][left] ~= map[i][right] then
            return false
        end
    end
    return checkVertical(map, left - 1, right + 1)
end

local function countHVReflections(map)
    local ref = {}
    local reps = 0
    for y = 1, #map do
        if checkHorizontal(map, y, y + 1) then
            reps = reps + 1
            table.insert(ref, {
                val = y,
                type = IS_HORIZONTAL
            })
        end
    end
    for x = 1, #map[1] do
        if checkVertical(map, x, x + 1) then
            reps = reps + 1
            table.insert(ref, {
                val = x,
                type = IS_VERTICAL
            })
        end
    end
    return ref
end

local function countHVReflectionWithSmudge(map)
    local originalReflection = countHVReflections(map)
    local originalChar = ""
    local newReflections = {}
    for y = 1, #map do
        for x = 1, #map[y] do
            originalChar = map[y][x]

            if originalChar == "#" then
                map[y][x] = "."
            else
                map[y][x] = "#"
            end

            newReflections = countHVReflections(map)

            map[y][x] = originalChar

            if #newReflections > 0 then
                for _, ref in ipairs(newReflections) do
                    if originalReflection[1].type == ref.type then
                        if originalReflection[1].val ~= ref.val then
                            return ref
                        end
                    else
                        return ref
                    end
                end
            end
        end
    end
    error("No se encontró reflection en todo el mapa modificado")
end

local function answer1()
    local maps = getInput()
    local vertical = 0
    local horizontal = 0
    local reflections = {}
    for i, map in ipairs(maps) do
        reflections = countHVReflections(map)[1]
        if reflections.type == IS_HORIZONTAL then
            horizontal = horizontal + reflections.val
        elseif reflections.type == IS_VERTICAL then
            vertical = vertical + reflections.val
        end
    end
    return vertical + horizontal * 100
end

local function answer2()
    local maps = getInput()
    local vertical = 0
    local horizontal = 0
    local reflection = {}
    for i, map in ipairs(maps) do
        reflection = countHVReflectionWithSmudge(map)
        if reflection.type == IS_HORIZONTAL then
            horizontal = horizontal + reflection.val
        elseif reflection.type == IS_VERTICAL then
            vertical = vertical + reflection.val
        end
    end
    return vertical + horizontal * 100
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
