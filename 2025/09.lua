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

    -- producto cruzado == 0 → colineales
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

        -- Ignorar aristas horizontales (previene division por 0 y errores)
        if yi ~= yj then
            -- Ver si el punto está entre las alturas del segmento
            local above = yi > y
            local above2 = yj > y

            if above ~= above2 then
                -- Calcular la intersección y ver si está a la izquierda del punto
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
            local c = {
                x = b.x,
                y = a.y
            }
            local d = {
                x = a.x,
                y = b.y
            }
            if pip(a.x, b.y) and pip(b.x, b.y) and pip(c.x, c.y) and pip(d.x, d.y) then
                local width = math.abs(a.x - b.x) + 1
                local height = math.abs(a.y - b.y) + 1
                local size = width * height
                if size > biggest then
                    biggest = size
                end
            end

        end
    end
    return biggest
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
-- es muy alta 4589698500
-- es muy alta 4596248639
