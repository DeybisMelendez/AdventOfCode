local aoc = require "lib.aoc"

local function getInput()
    local input = aoc.input.getInput()
    local cases = {}

    for line in input:gmatch("[^\n]+") do
        -- Detecta líneas tipo "4x4: 0 0 0 0 2 0"
        local w, h, rest = line:match("^(%d+)x(%d+):%s*(.+)$")
        if w then
            local vals = {}
            for num in rest:gmatch("%d+") do
                table.insert(vals, tonumber(num))
            end

            table.insert(cases, {
                w = tonumber(w),
                h = tonumber(h),
                values = vals
            })
        end
    end

    return cases

end

local function answer1()
    local input = getInput()
    local total = 0
    for i = 1, #input do
        local case = input[i]
        local result = 0
        for j = 1, #case.values do
            local value = case.values[j]
            result = result + value
        end
        if result * 7 < case.w * case.h then
            total = total + 1
        end
    end
    return total
end

print("answer 1 is " .. answer1())
