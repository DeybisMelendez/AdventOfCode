local file = io.open("day13input.txt", "r")
local text = file:read("*a")
file:close()
text = text:gsub(" would", "")
text = text:gsub("happiness units by sitting next to ", "")
text = text:gsub("%.", "")
function contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end
local input = split(text, "[^\n]+")
local people = {}
for i,v in ipairs(input) do
    input[i] = split(v, "[^%s]+")
    if not contains(people, input[i][1]) then
        table.insert(people, input[i][1])
    end
end

local function merge(t1,t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

local function concat(a,b)
    for i=1, #b do
        table.insert(b[i], a)
    end
    return b
end

local function permute(t)
    local perm = {}
    if #t > 2 then
        for i, v in ipairs(t) do
            local topermute = {}
            for i2, v2 in ipairs(t) do
                if not(i == i2) then
                    table.insert(topermute, v2)
                end
            end
            perm = merge(perm, concat(v, permute(topermute)))
        end
        return perm
    else
        return {{t[1],t[2]}, {t[2],t[1]}}
    end
end

local combs = permute({1,2,3,4,5})
for i,v in ipairs(combs) do
    for i2,v2 in ipairs(v) do
        io.write(v2 .. ", ")
    end
    io.write("\n")
end