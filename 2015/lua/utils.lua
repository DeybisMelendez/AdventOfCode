-- String functions
function string.split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

function string.readFile(file)
    local file = io.open(file, "r")
    local text = file:read("*a")
    file:close()
    return text
end

-- Table functions
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function table.index(t, val)
    for k,v in pairs(t) do
        if v == val then return k end
    end
end

function table.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function table.copy(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end

function table.merge(t1,t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

function table.concat(a,b)
    for i=1, #b do
        table.insert(b[i], a)
    end
    return b
end

function table.permute(t)
    local perm = {}
    if #t > 2 then
        for i, v in ipairs(t) do
            local topermute = {}
            for i2, v2 in ipairs(t) do
                if not(i == i2) then
                    table.insert(topermute, v2)
                end
            end
            perm = table.merge(perm, table.concat(v, table.permute(topermute)))
        end
        return perm
    else
        return {{t[1],t[2]}, {t[2],t[1]}}
    end
end