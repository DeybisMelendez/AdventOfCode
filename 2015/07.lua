-- No funciona en Luajit
local aoc = require "lib.aoc"

local input = aoc.string.split(aoc.input.getInput("input.txt"), "\n")

local wires = {}
local result = {}

local function calc(name)
    local val = 0
    if result[name] then
        return result[name]
    end
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
    return val
end

local function answer1(x)
    result = {}
    for _, ins in ipairs(input) do
        ins = aoc.string.split(ins, "->")
        ins[2] = string.gsub(ins[2], "%s", "")
        wires[ins[2]] = aoc.string.split(ins[1], "%s")
    end
    return calc(x)
end

local function answer2(x)
    local b = result["a"]
    result = {}
    result["b"] = b
    return calc(x)
end

print("answer 1 is " .. answer1("a"))
print("answer 2 is " .. answer2("a"))
