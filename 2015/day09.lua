local file = io.open("day09input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end
text = string.gsub(text, " to", "")
text = string.gsub(text, " =", "")
local distances = split(text, "[^\n]+")
local cities = {}

for i=1, #distances do
    local distance = distances[i]
    distance = split(distance, "[^%s]+")
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

local function merge(t1,t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

local function permute2(a,b)
    return {{a,b}, {b,a}}
end

local function concat(a,b)
    for i=1, #b do
        table.insert(b[i], a)
    end
    return b
end

local function permute3(a,b,c)
    local r1 = concat(a, permute2(b,c))
    local r2 = concat(b, permute2(a,c))
    local r3 = concat(c, permute2(a,b))
    local m1 = merge(r1, r2)
    return merge(m1, r3)
end

local function permute4(a,b,c,d)
    local r1 = concat(a, permute3(b,c,d))
    local r2 = concat(b, permute3(a,c,d))
    local r3 = concat(c, permute3(a,b,d))
    local r4 = concat(d, permute3(a,b,c))
    return merge(merge(r1,r2), merge(r3,r4))
end

local function permute5(a,b,c,d,e)
    local r1 = concat(a, permute4(b,c,d,e))
    local r2 = concat(b, permute4(a,c,d,e))
    local r3 = concat(c, permute4(a,b,d,e))
    local r4 = concat(d, permute4(a,b,c,e))
    local r5 = concat(e, permute4(a,b,c,d))
    return merge(merge(merge(r1,r2), merge(r3,r4)), r5)
end

local function permute6(a,b,c,d,e,f)
    local r1 = concat(a, permute5(b,c,d,e,f))
    local r2 = concat(b, permute5(a,c,d,e,f))
    local r3 = concat(c, permute5(a,b,d,e,f))
    local r4 = concat(d, permute5(a,b,c,e,f))
    local r5 = concat(e, permute5(a,b,c,d,f))
    local r6 = concat(f, permute5(a,b,c,d,e))
    local m1 = merge(r1,r2)
    local m2 = merge(r3,r4)
    local m3 = merge(r5,r6)
    return merge(merge(m1,m2),m3)
end

local function permute7(a,b,c,d,e,f,g)
    local r1 = concat(a, permute6(b,c,d,e,f,g))
    local r2 = concat(b, permute6(a,c,d,e,f,g))
    local r3 = concat(c, permute6(a,b,d,e,f,g))
    local r4 = concat(d, permute6(a,b,c,e,f,g))
    local r5 = concat(e, permute6(a,b,c,d,f,g))
    local r6 = concat(f, permute6(a,b,c,d,e,g))
    local r7 = concat(g, permute6(a,b,c,d,e,f))
    local m1 = merge(r1,r2)
    local m2 = merge(r3,r4)
    local m3 = merge(r5,r6)
    m1 = merge(m1, r7)
    m2 = merge(m2,m3)
    return merge(m1,m2)
end

local function permute8(a,b,c,d,e,f,g,h)
    local r1 = concat(a, permute7(b,c,d,e,f,g,h))
    local r2 = concat(b, permute7(a,c,d,e,f,g,h))
    local r3 = concat(c, permute7(a,b,d,e,f,g,h))
    local r4 = concat(d, permute7(a,b,c,e,f,g,h))
    local r5 = concat(e, permute7(a,b,c,d,f,g,h))
    local r6 = concat(f, permute7(a,b,c,d,e,g,h))
    local r7 = concat(g, permute7(a,b,c,d,e,f,h))
    local r8 = concat(h, permute7(a,b,c,d,e,f,g))
    local m1 = merge(r1,r2)
    local m2 = merge(r3,r4)
    local m3 = merge(r5,r6)
    local m4 = merge(r7,r8)
    m1 = merge(m1, m3)
    m2 = merge(m2, m4)
    return merge(m1,m2)
end

local function calcDistances()
    local dists = {}
    local perms = permute8(nodes[1], nodes[2], nodes[3], nodes[4],
        nodes[5], nodes[6], nodes[7], nodes[8])
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