local aoc = require "lib.aoc"
local input = aoc.input.getInput()

local function getIndividualBlocks()
    local diskMap = aoc.string.splitToChar(input)
    local individualBlocks = {}
    local freeSpace = 0
    local isBlock = true
    local id = 0
    for _, digit in ipairs(diskMap) do
        local blocks = tonumber(digit)
        if isBlock then
            for _ = 1, blocks do
                table.insert(individualBlocks, id)
            end
            id = id + 1
        else
            for _ = 1, blocks do
                table.insert(individualBlocks, -1)
                freeSpace = freeSpace + 1
            end
        end
        isBlock = not isBlock
    end
    individualBlocks.freeSpace = freeSpace
    return individualBlocks
end

local function compactIndividualBlocks(individualBlocks)
    local i = #individualBlocks
    local j = 1
    for _ = 1, individualBlocks.freeSpace do
        if individualBlocks[i] ~= -1 then
            while individualBlocks[j] ~= -1 do
                j = j + 1
            end
            individualBlocks[j] = individualBlocks[i]
            individualBlocks[i] = -1
        end
        i = i - 1
    end
end

local function getChecksum(individualBlocks)
    local totalChecksum = 0
    for i = 0, #individualBlocks - individualBlocks.freeSpace - 1 do
        if individualBlocks[i + 1] ~= -1 then
            totalChecksum = totalChecksum + individualBlocks[i + 1] * i
        end
    end
    return totalChecksum
end

local function getFileBlocks(individualBlocks)
    local fileBlocks = {}
    local actual = individualBlocks[1]
    local file = { tonumber(actual) }

    for i = 2, #individualBlocks do
        local num = individualBlocks[i]
        if num == "." then
            table.insert(file, -1)
        elseif num == actual then
            table.insert(file, tonumber(num))
        else
            table.insert(fileBlocks, file)
            actual = num
            file = { tonumber(actual) }
        end
    end

    -- Agregar el último file
    table.insert(fileBlocks, file)

    return fileBlocks
end

local function compactFileBlocks(fileBlocks)
    local i = #fileBlocks
    while i > 0 do
        if fileBlocks[i][1] ~= -1 then
            for j = 1, i - 1 do
                if fileBlocks[j][1] == -1 then
                    if #fileBlocks[j] >= #fileBlocks[i] then
                        local diff = #fileBlocks[j] - #fileBlocks[i]
                        fileBlocks[j] = { unpack(fileBlocks[i]) }

                        local newEmpty = {}

                        for _ = 1, diff do
                            table.insert(newEmpty, -1)
                        end
                        for k = 1, #fileBlocks[i] do
                            fileBlocks[i][k] = -1
                        end
                        if diff > 0 then
                            table.insert(fileBlocks, j + 1, newEmpty)
                            i = i + 1
                        end
                        break
                    end
                end
            end
        end
        i = i - 1
    end
    local compactedFileBlocks = {}
    for _, block in ipairs(fileBlocks) do
        for _, num in ipairs(block) do
            table.insert(compactedFileBlocks, num)
        end
    end
    compactedFileBlocks.freeSpace = 0
    return compactedFileBlocks
end

local function answer1()
    local individualBlocks = getIndividualBlocks()
    compactIndividualBlocks(individualBlocks)
    return getChecksum(individualBlocks)
end

local function answer2()
    local individualBlocks = getIndividualBlocks()
    local fileBlocks = getFileBlocks(individualBlocks)
    return getChecksum(compactFileBlocks(fileBlocks))
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
