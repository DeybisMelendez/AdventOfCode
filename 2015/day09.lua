require "utils"
local text = string.readFile("day09input.txt")

text = string.gsub(text, " to", "")
text = string.gsub(text, " =", "")
local distances = string.split(text, "[^\n]+")
local cities = {}

for i=1, #distances do
    local distance = distances[i]
    distance = string.split(distance, "[^%s]+")
    if cities[distance[1]] == nil then
        cities[distance[1]] = {}
    end
    if cities[distance[2]] == nil then
        cities[distance[2]] = {}
    end
    cities[distance[1]][distance[2]] = tonumber(distance[3])
    cities[distance[2]][distance[1]] = tonumber(distance[3])
end
local nodes = {}
for i,_ in pairs(cities) do
    table.insert(nodes, i)
end

local function calcDistances()
    local dists = {}
    local perms = table.permute(nodes)
    for _,v in ipairs(perms) do
        local d1 = cities[v[1]][v[2]]
        local d2 = cities[v[2]][v[3]]
        local d3 = cities[v[3]][v[4]]
        local d4 = cities[v[4]][v[5]]
        local d5 = cities[v[5]][v[6]]
        local d6 = cities[v[6]][v[7]]
        local d7 = cities[v[7]][v[8]]
        table.insert(dists, d1+d2+d3+d4+d5+d6+d7)
    end
    return dists
end

local function answer1()
    local results = calcDistances()
    local value
    for i=1, #results do
        if value == nil then
            value = results[i]
        elseif value > results[i] then
            value = results[i]
        end
    end
    return value
end

local function answer2()
    local results = calcDistances()
    local value
    for i=1, #results do
        if value == nil then
            value = results[i]
        elseif value < results[i] then
            value = results[i]
        end
    end
    return value
end

print(answer1())
print(answer2())