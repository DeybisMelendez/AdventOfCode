local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

local function answer1()
    local total = 0
    for i = 1, #input do
        local line = input[i]
        local maxNumber = 0
        local indexNumber = 0
        local secondMaxNumber = 0
        for j = 1, #line-1 do
            local char = line:sub(j, j)
            if tonumber(char) > maxNumber then
                maxNumber = tonumber(char)
                indexNumber = j
            end
        end
        for j = indexNumber+1, #line do
            local char = line:sub(j, j)
            if tonumber(char) > secondMaxNumber then
                secondMaxNumber = tonumber(char)
            end
        end
        total = total + (maxNumber * 10 + secondMaxNumber)
        --print("Line " .. i .. ": " .. maxNumber .. " " .. secondMaxNumber .. " => " .. (maxNumber * 10 + secondMaxNumber))
    end
    return total
end

local function answer2()
    local total = 0

    for _, line in ipairs(input) do
        local digits = {} -- stack
        local remove = #line - 12 -- how many digits to remove to leave 12
        for i = 1, #line do -- for each digit
            local d = line:sub(i, i)

            -- while we can remove and the last digit is less than current
            while remove > 0 and #digits > 0 and digits[#digits] < d do
                table.remove(digits) -- pop
                remove = remove - 1
            end

            table.insert(digits, d) -- push
        end

        -- if we still have to remove digits
        while remove > 0 do
            table.remove(digits) -- pop
            remove = remove - 1
        end

        local result = table.concat(digits) -- join to string
        total = total + tonumber(result)

        --print(line .. " => " .. result)
    end

    return total
end

print("Answer 1: " .. answer1())
print(string.format("Answer 2: %18.0f",answer2()))