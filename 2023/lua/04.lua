require "utils"

local totalScratchcards = 0
local scratchcards = {}

local function isWinner(number, winners)
    for _, value in pairs(winners) do
        if tonumber(value) == tonumber(number) then
            return true
        end
    end
    return false
end

local function getTotalScratchcards(index)
    for i = 1, scratchcards[index] do
        getTotalScratchcards(index + i)
        totalScratchcards = totalScratchcards + 1
    end
end

local function answer1()
    local input = readFile("04input.txt")
    local lines = splitString(input, lineDelimiter)
    local parts = {}
    local numbers = {}
    local winners = {}
    local points = 0
    local total = 0
    for _, line in ipairs(lines) do
        line = line:gsub("|", ":")
        parts = splitString(line, colonDelimiter) -- 3 partes: parte 1: Card, parte 2: Numeros, parte 3: Numeros ganadores
        numbers = splitString(parts[2], spaceDelimiter)
        winners = splitString(parts[3], spaceDelimiter)
        points = 0
        for _, number in ipairs(numbers) do
            if isWinner(number, winners) then
                if points == 0 then
                    points = 1
                else
                    points = points * 2
                end
            end
        end
        total = total + points
    end
    return total
end

local function answer2()
    scratchcards = {}
    totalScratchcards = 0
    local input = readFile("04input.txt")
    local lines = splitString(input, lineDelimiter)
    local parts = {}
    local numbers = {}
    local winners = {}
    local card = ""
    local points = 0

    for _, line in ipairs(lines) do
        line = line:gsub("|", ":")
        parts = splitString(line, colonDelimiter) -- 3 partes: parte 1: Card, parte 2: Numeros, parte 3: Numeros ganadores
        card = tonumber(parts[1]:sub(5, -1))
        numbers = splitString(parts[2], spaceDelimiter)
        winners = splitString(parts[3], spaceDelimiter)
        points = 0
        for _, number in ipairs(numbers) do
            if isWinner(number, winners) then
                points = points + 1
            end
        end
        table.insert(scratchcards, points) -- Casualmente Lua indexa desde 1
    end

    for card = 1, #scratchcards do
        getTotalScratchcards(card)
        totalScratchcards = totalScratchcards + 1
    end

    return totalScratchcards
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
