local aoc = require "lib.aoc"
local UF = require "2025.uf"

local raw = aoc.input.getInput()
local lines = aoc.string.split(raw, "\n")

local N = #lines
local posData = {}
local memo = {}

local function distance3D(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    local dz = a.z - b.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function makeUF()
    local uf = UF.new()
    for i = 1, N do
        uf:make(i)
    end
    return uf
end

local function setup()
    for i = 1, N do
        local p = aoc.string.split(lines[i], ",")
        posData[i] = {
            x = tonumber(p[1]),
            y = tonumber(p[2]),
            z = tonumber(p[3])
        }
    end
    local k = 1
    for i = 1, N do
        local A = posData[i]
        for j = i + 1, N do
            memo[k] = {
                dist = distance3D(A, posData[j]),
                a = i,
                b = j
            }
            k = k + 1
        end
    end

    table.sort(memo, function(a, b)
        return a.dist < b.dist
    end)
end

local function answer1()
    local uf = makeUF()

    for i = 1, N do
        local e = memo[i]
        uf:union(e.a, e.b)
    end

    local sizes = {}
    for i = 1, N do
        local r = uf:find(i)
        sizes[r] = (sizes[r] or 0) + 1
    end

    local list = {}
    for _, s in pairs(sizes) do
        list[#list + 1] = s
    end
    table.sort(list, function(a, b)
        return a > b
    end)

    return list[1] * list[2] * list[3]
end

local function answer2()
    local uf = makeUF()
    local components = N

    for i = 1, #memo do
        local e = memo[i]
        if uf:union(e.a, e.b) then
            components = components - 1

            if components == 1 then
                return posData[e.a].x * posData[e.b].x
            end
        end
    end

    return -1 -- nunca debería ocurrir
end

setup()
print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
