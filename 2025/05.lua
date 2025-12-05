local aoc = require "lib.aoc"
local inputText =  aoc.input.getInput()
local input = {
    ranges = aoc.string.split(inputText:match("(.*)\n\n"), "\n"),
    ids = aoc.string.split(inputText:match(".*\n\n(.*)"), "\n"),
}

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

print("answer 1 is " .. answer1())