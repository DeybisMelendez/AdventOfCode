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

local function getOp(ins)
    ins = split(ins, "[^%s]+")
    if #ins == 3 then
        if ins[2] == "AND" then
            return function()
                return (tonumber(ins[1]) or tonumber(wires[ins[1]]())) & (tonumber(ins[3]) or tonumber(wires[ins[3]]()))
            end
        elseif ins[2] == "OR" then
            return function()
                return (tonumber(ins[1]) or tonumber(wires[ins[1]]())) | (tonumber(ins[3]) or tonumber(wires[ins[3]]()))
            end
        elseif ins[2] == "LSHIFT" then
            return function()
                return (tonumber(ins[1]) or tonumber(wires[ins[1]]())) << (tonumber(ins[3]) or tonumber(wires[ins[3]]()))
            end
        elseif ins[2] == "RSHIFT" then
            return function()
                return (tonumber(ins[1]) or tonumber(wires[ins[1]]())) >> (tonumber(ins[3]) or tonumber(wires[ins[3]]()))
            end
        end
    elseif #ins == 2 then
        return function()
            return 65536 + ~(tonumber(ins[2]) or tonumber(wires[ins[2]]()))
        end
    elseif #ins == 1 then
        return function() return tonumber(ins[1]) or tonumber(wires[ins[1]]()) end
    end
end

local function answer1(x)
    for i=1, #instructions do
        local ins = instructions[i]
        ins = split(ins, "[^->]+")
        ins[2] = string.gsub(ins[2], "%s","")
        wires[ins[2]] = getOp(ins[1])
    end
    return wires[x]()
end
print(answer1("ee"))
