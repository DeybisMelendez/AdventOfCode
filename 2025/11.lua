local aoc = require "lib.aoc"
local raw = aoc.input.getInput()
raw = aoc.string.split(raw, "\n")
local input = {}
local memo = {}

for i = 1, #raw do
    local line = aoc.string.split(raw[i], ":%s")
    input[line[1]] = {}
    for j = 2, #line do
        table.insert(input[line[1]], line[j])
    end
end

local function dfs(actualServer)
    if actualServer == "out" then
        return 1
    end
    local total = 0
    for i = 1, #input[actualServer] do
        local server = input[actualServer][i]
        if memo[server] then
            return 0
        end
        memo[server] = true
        total = total + dfs(server)
        memo[server] = false
    end
    return total
end

local function answer1()
    return dfs("you")
end

print("answer 1 is " .. answer1())
