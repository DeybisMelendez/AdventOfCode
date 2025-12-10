local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

for i = 1, #input do
    local line = aoc.string.split(input[i], ",")
    input[i] = {
        x = tonumber(line[1]),
        y = tonumber(line[2])
    }
end

-- Point on Segment
local function pos(px, py, x1, y1, x2, y2)
    local minx, maxx = math.min(x1, x2), math.max(x1, x2)
    local miny, maxy = math.min(y1, y2), math.max(y1, y2)

    if px < minx or px > maxx or py < miny or py > maxy then
        return false
    end

    return (x2 - x1) * (py - y1) == (y2 - y1) * (px - x1)
end

-- Point in Poly
local function pip(x, y)
    local inside = false
    local j = #input

    for i = 1, #input do
        local xi, yi = input[i].x, input[i].y
        local xj, yj = input[j].x, input[j].y

        if pos(x, y, xi, yi, xj, yj) then
            return true
        end

        if yi ~= yj then
            local above = yi > y
            local above2 = yj > y

            if above ~= above2 then
                local x_intersect = (xj - xi) * (y - yi) / (yj - yi) + xi
                if x < x_intersect then
                    inside = not inside
                end
            end
        end

        j = i
    end

    return inside
end

local function answer1()
    local biggest = 0
    for i = 1, #input do
        local a = input[i]
        for j = i + 1, #input do
            local b = input[j]
            local size = (math.abs(a.x - b.x) + 1) * (math.abs(a.y - b.y) + 1)
            if size > biggest then
                biggest = size
            end
        end
    end
    return biggest
end

local function answer2()
    local biggest = 0
    for i = 1, #input do
        local a = input[i]
        for j = i + 1, #input do
            local b = input[j]

            local width = math.abs(a.x - b.x) + 1
            local height = math.abs(a.y - b.y) + 1
            local size = width * height

            if size > biggest then
                local minx = math.min(a.x, b.x)
                local maxx = math.max(a.x, b.x)
                local miny = math.min(a.y, b.y)
                local maxy = math.max(a.y, b.y)
                local valid = true

                -- Mi truco para optimizar es reduciendo la cantidad de puntos
                -- a evaluar, a mi me funcionó evaluando cada 1500 puntos en cada recta.

                -- recorrer borde superior e inferior
                for x = minx, maxx, 1500 do
                    if not pip(x, miny) or not pip(x, maxy) then
                        valid = false
                        break
                    end
                end

                -- si sigue válido, recorrer laterales
                if valid then
                    for y = miny, maxy, 1500 do
                        if not pip(minx, y) or not pip(maxx, y) then
                            valid = false
                            break
                        end
                    end
                end

                if valid then
                    biggest = size
                end
            end
        end
    end
    return biggest
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
