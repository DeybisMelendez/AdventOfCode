local aoc = require "lib.aoc"
local UF = require "2025.uf"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

local function distance3D(pos1, pos2)
    local x = math.abs(pos1.x - pos2.x)
    local y = math.abs(pos1.y - pos2.y)
    local z = math.abs(pos1.z - pos2.z)
    return math.sqrt(x * x + y * y + z * z)
end

local function answer1()
    local memo = {}
    local posData = {}
    local keys = {}

    for i = 1, #input do
        local pos = aoc.string.split(input[i], ",")
        local obj = {
            x = tonumber(pos[1]),
            y = tonumber(pos[2]),
            z = tonumber(pos[3]),
            str = input[i]
        }
        posData[i] = obj
        keys[#keys + 1] = i
    end

    for i = 1, #input do
        local pos1 = posData[i]
        for j = i + 1, #input do
            local pos2 = posData[j]
            local dist = distance3D(pos1, pos2)
            memo[#memo + 1] = {
                dist = dist,
                a = i,
                b = j
            }
        end
    end

    table.sort(memo, function(a, b)
        return a.dist < b.dist
    end)

    local uf = UF.new()
    for i = 1, #input do
        uf:make(i)
    end

    for i = 1, 1000 do
        uf:union(memo[i].a, memo[i].b)
    end

    local sizes = {}
    for i = 1, #input do
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

    local ans = list[1] * list[2] * list[3]

    return ans
end

local function answer2()
    local memo = {}
    local posData = {}
    local N = #input

    for i = 1, N do
        local pos = aoc.string.split(input[i], ",")
        posData[i] = {
            x = tonumber(pos[1]),
            y = tonumber(pos[2]),
            z = tonumber(pos[3]),
            str = input[i]
        }
    end

    for i = 1, N do
        local pos1 = posData[i]
        for j = i + 1, N do
            local pos2 = posData[j]
            memo[#memo + 1] = {
                dist = distance3D(pos1, pos2),
                a = i,
                b = j
            }
        end
    end

    table.sort(memo, function(a, b)
        return a.dist < b.dist
    end)

    local uf = UF.new()
    for i = 1, N do
        uf:make(i)
    end

    local components = N

    for i = 1, #memo do
        local a = memo[i].a
        local b = memo[i].b

        if uf:union(a, b) then
            components = components - 1

            if components == 1 then
                return posData[a].x * posData[b].x
            end
        end
    end

    return -1 -- no debería pasar
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
