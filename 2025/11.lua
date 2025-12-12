local aoc = require "lib.aoc"
local raw = aoc.input.getInput()
raw = aoc.string.split(raw, "\n")
local input = {}

for i = 1, #raw do
    local line = aoc.string.split(raw[i], ":%s")
    if #line > 1 then
        local node = line[1]
        input[node] = input[node] or {}
        for j = 2, #line do
            table.insert(input[node], line[j])
        end
    end
end

local function dfs_simple(node, target, visited)
    if node == target then
        return 1
    end
    if not input[node] then
        return 0
    end

    visited[node] = true
    local total = 0

    for _, nxt in ipairs(input[node]) do
        if not visited[nxt] then
            total = total + dfs_simple(nxt, target, visited)
        end
    end

    visited[node] = false
    return total
end

local dp = {}

local function dfs2(node, seen_dac, seen_fft, visited)
    if node == "out" then
        if seen_dac and seen_fft then
            return 1
        else
            return 0
        end
    end

    if not input[node] then
        return 0
    end

    dp[node] = dp[node] or {}
    dp[node][seen_dac] = dp[node][seen_dac] or {}
    if dp[node][seen_dac][seen_fft] ~= nil then
        return dp[node][seen_dac][seen_fft]
    end

    visited[node] = true

    local new_seen_dac = seen_dac or (node == "dac")
    local new_seen_fft = seen_fft or (node == "fft")

    local total = 0

    for _, nxt in ipairs(input[node]) do
        if not visited[nxt] then
            total = total + dfs2(nxt, new_seen_dac, new_seen_fft, visited)
        end
    end

    visited[node] = false
    dp[node][seen_dac][seen_fft] = total
    return total
end

local function answer1()
    return dfs_simple("you", "out", {})
end

local function answer2()
    dp = {}
    return dfs2("svr", false, false, {})
end

print("answer 1 is " .. answer1())
print(string.format("Answer 2: %18.0f", answer2()))
