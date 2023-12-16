require "utils"

local function isWinner(number, winners)
    for _, winner in ipairs(winners) do
        if number == winner then
            return true
        end
    end
    return false
end

local function getTotalScratchcards(index, cards)

    -- si el total ya fue calculado se devuelve directamente
    if cards[index].total ~= -1 then
        return cards[index].total
    end
    -- en caso contrario se calcula
    local total = 0

    for i = cards[index].points, 1, -1 do
        total = total + getTotalScratchcards(index + i, cards) + 1
    end
    -- se guarda el total calculado
    cards[index].total = total

    return total
end

local function getInput()
    local input = readFile("04input.txt")
    local lines = splitString(input, lineDelimiter)
    local parts = {}
    local games = {}
    local numbers = {}
    local winners = {}

    for i, line in ipairs(lines) do
        line = line:gsub("|", ":") -- cambiar | por : para dividir el juego en 3 partes
        parts = splitString(line, colonDelimiter) -- 3 partes: parte 1: Card, parte 2: Numeros, parte 3: Numeros ganadores
        numbers = splitString(parts[2], spaceDelimiter)
        winners = splitString(parts[3], spaceDelimiter)
        games[i] = {
            numbers = {},
            winners = {}
        }

        for j = 1, #numbers do
            table.insert(games[i].numbers, tonumber(numbers[j]))
        end

        for j = 1, #winners do
            table.insert(games[i].winners, tonumber(winners[j]))
        end
    end
    return games
end

local function answer1()
    local games = getInput()
    local points = 0
    local total = 0

    for _, game in ipairs(games) do
        points = 0

        for _, number in ipairs(game.numbers) do
            if isWinner(number, game.winners) then
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
    local scratchcards = {}
    local totalScratchcards = 0
    local games = getInput()
    local points = 0
    local total = 0

    for _, game in ipairs(games) do
        points = 0

        for _, number in ipairs(game.numbers) do
            if isWinner(number, game.winners) then
                points = points + 1
            end
        end

        table.insert(scratchcards, {
            points = points,
            total = -1
        }) -- Casualmente Lua indexa desde 1
    end

    for i = #scratchcards, 1, -1 do
        totalScratchcards = totalScratchcards + getTotalScratchcards(i, scratchcards) + 1
    end

    return totalScratchcards
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
