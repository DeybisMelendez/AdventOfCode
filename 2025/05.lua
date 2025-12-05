local aoc = require "lib.aoc"
local inputText =  aoc.input.getInput()
local input = {
    ranges = aoc.string.split(inputText:match("(.*)\n\n"), "\n"),
    ids = aoc.string.split(inputText:match(".*\n\n(.*)"), "\n"),
}
local memoID = {}

local function simplifyRanges(ranges)
    table.sort(ranges, function(a, b)
        return a[1] < b[1]
    end)

    local result = {}
    local current = ranges[1]

    for i = 2, #ranges do
        local r = ranges[i]

        if r[1] <= current[2] + 1 then
            current[2] = math.max(current[2], r[2])
        else
            table.insert(result, current)
            current = r
        end
    end

    table.insert(result, current)
    return result
end

local function answer1()
    local total = 0
    for _, id in ipairs(input.ids) do
        local num = tonumber(id)
        local inRange = false
        for _, range in ipairs(input.ranges) do
            local parts = aoc.string.split(range, "-")
            local low, high = tonumber(parts[1]), tonumber(parts[2])
            if num >= low and num <= high then
                inRange = true
                break
            end
        end
        if inRange then
            total = total + 1
        end
    end
    return total
end

local function answer2()
    local total = 0
    for _, range in ipairs(input.ranges) do
        local parts = aoc.string.split(range, "-")
        local low, high = tonumber(parts[1]), tonumber(parts[2])
        local inserted = false
        for _, memo in ipairs(memoID) do
            if memo[1] >= low and memo[1] <= high then
                memo[1] = low
                inserted = true
            end
            if memo[2] >= low and memo[2] <= high then
                memo[2] = high
                inserted = true
            end
        end
        if not inserted then
            table.insert(memoID, {low, high})
        end
    end
    memoID = simplifyRanges(memoID)
    for _,range in ipairs(memoID) do
        total = total + range[2] - range[1] + 1
    end
    return total
end

print("answer 1 is " .. answer1())
print(string.format("Answer 2: %18.0f",answer2()))