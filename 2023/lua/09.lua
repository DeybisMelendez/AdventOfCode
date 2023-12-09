require "utils"

local function getInput()
    local input = readFile("09.input")
    local lines = splitString(input, lineDelimiter)
    local list = {}
    local numbers = {}
    for i, line in ipairs(lines) do
        line = splitString(line, spaceDelimiter)
        list[i] = {}
        for j, number in ipairs(line) do
            list[i][j] = tonumber(number)
        end
    end
    return list
end

local function isSequenceStable(history)
    local isStable = true
    for i = #history, 3, -1 do
        if history[i] - history[i - 1] ~= history[i - 1] - history[i - 2] then
            isStable = false
            break
        end
    end
    return isStable
end

local function answer1(input)
    local total = 0
    local lastNumberSequences = {}
    local lastDiffSequences = 0
    local newHistory = {}
    for _, history in ipairs(input) do
        lastNumberSequences = {history[#history]}
        lastDiffSequences = history[#history] - history[#history - 1]
        while not isSequenceStable(history) do
            newHistory = {}
            for i = 1, #history - 1 do
                table.insert(newHistory, history[i + 1] - history[i])
            end
            history = newHistory
            table.insert(lastNumberSequences, history[#history])
            lastDiffSequences = history[#history] - history[#history - 1]
        end
        for _, value in ipairs(lastNumberSequences) do
            lastDiffSequences = lastDiffSequences + value
        end
        total = total + lastDiffSequences
    end
    return total
end

local function answer2(input)
    local inverseInput = {}
    local inverseHistory = {}
    for _, history in ipairs(input) do
        inverseHistory = {}
        for i = #history, 1, -1 do
            table.insert(inverseHistory, history[i])
        end
        table.insert(inverseInput, inverseHistory)
    end
    return answer1(inverseInput)
end

print("Parte 1:", answer1(getInput()))
print("Parte 2:", answer2(getInput()))
