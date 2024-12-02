local aoc = require "lib.aoc"

local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

for i, v in ipairs(input) do
    input[i] = aoc.string.split(v, "%s")
    for j, n in ipairs(input[i]) do
        input[i][j] = tonumber(n)
    end
end

local function isReportSafe(report)
    local increasing = report[1] < report[2]
    for i = 1, #report - 1 do
        local actualLevel = report[i]
        local nextLevel = report[i + 1]
        if actualLevel < nextLevel ~= increasing then
            return false
        end
        local differ = math.abs(actualLevel - nextLevel)
        if differ < 1 or differ > 3 then
            return false
        end
    end
    return true
end

local function answer1()
    local totalSafe = 0
    for _, report in ipairs(input) do
        if isReportSafe(report) then
            totalSafe = totalSafe + 1
        end
    end
    return totalSafe
end

local function answer2()
    local totalSafe = 0
    for _, report in ipairs(input) do
        if isReportSafe(report) then
            totalSafe = totalSafe + 1
            goto continue
        end
        for i = 1, #report do
            local num = table.remove(report, i)
            if isReportSafe(report) then
                totalSafe = totalSafe + 1
                break
            end
            table.insert(report, i, num)
        end
        ::continue::
    end
    return totalSafe
end
print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
