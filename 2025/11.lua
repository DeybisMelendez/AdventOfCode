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

local function dfs(actualServer, isPart1)
    if isPart1 then
        if actualServer == "out" then
            return 1
        end
    else
        if actualServer == "out" then
            if memo["is_dac"] and memo["is_fft"] then
                return 1
            end
            return 0
        end
    end
    local total = 0
    for i = 1, #input[actualServer] do
        local server = input[actualServer][i]
        if memo[server] then
            return 0
        end
        memo[server] = true
        if not isPart1 then
            if server == "dac" then
                memo["is_dac"] = true
            end
            if server == "fft" then
                memo["is_fft"] = true
            end
        end
        total = total + dfs(server, isPart1)
        if not isPart1 then
            if server == "dac" then
                memo["is_dac"] = false
            end
            if server == "fft" then
                memo["is_fft"] = false
            end
        end
        memo[server] = false
    end
    return total
end

local function answer1()
    return dfs("svr", true)
end

local function answer2()
    return dfs("svr", false)
end

print("answer 1 is " .. answer1())
-- print("answer 2 is " .. answer2())
