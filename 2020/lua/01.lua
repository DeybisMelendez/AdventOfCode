local utils = require"utils"

local INPUT = utils.readFile("01.input")

function answer1(input)
    local inputTable = utils.split(input, utils.lineDelimiter)

    for i = 1, #inputTable-2 do
        local v1 = inputTable[i]
        for j = i+1, #inputTable-1 do
            local v2 = inputTable[j]
            if v1 + v2 == 2020 then
                return v1 * v2
            end
        end
    end
end

function answer2(input)
    local inputTable = utils.split(input, utils.lineDelimiter)
    for i = 1, #inputTable-2 do
        for j = i+1, #inputTable-1 do
            for k = j+1, #inputTable do
                local v1 = inputTable[i]
                local v2 = inputTable[j]
                local v3 = inputTable[k]
                if v1 + v2 + v3 == 2020 then
                    return v1 * v2 * v3
                end
            end
        end
    end
end

print("The answer 1 is", answer1(INPUT))
print("The answer 2 is", answer2(INPUT))