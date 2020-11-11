local file = io.open("day07input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end
local instructions = split(text, "[^\n]+")
local wires = {}
local result = {}

local function calc(name)
    local val
    if not result[name] then
        local ins = wires[name]
        if #ins == 3 then
            if ins[2] == "AND" then
                local a = tonumber(ins[1]) or calc(ins[1])
                local b = tonumber(ins[3]) or calc(ins[3])
                val = a & b
            elseif ins[2] == "OR" then
                local a = tonumber(ins[1]) or calc(ins[1])
                local b = tonumber(ins[3]) or calc(ins[3])
                val = a | b
            elseif ins[2] == "LSHIFT" then
                local a = tonumber(ins[1]) or calc(ins[1])
                local b = tonumber(ins[3]) or calc(ins[3])
                return a << b
            elseif ins[2] == "RSHIFT" then
                local a = tonumber(ins[1]) or calc(ins[1])
                local b = tonumber(ins[3]) or calc(ins[3])
                val = a >> b
            end
        elseif #ins == 2 then
            local a = tonumber(ins[2]) or calc(ins[2])
            val = 65536 + ~a
        elseif #ins == 1 then
            val = tonumber(ins[1]) or calc(ins[1])
        end
        result[name] = val
    end
    return result[name]
end

local function answer1(x)
    for i=1, #instructions do
        local ins = instructions[i]
        ins = split(ins, "[^->]+")
        ins[2] = string.gsub(ins[2], "%s","")
        wires[ins[2]] = split(ins[1], "[^%s]+")
    end
    return calc(x)
end
print(answer1("a"))