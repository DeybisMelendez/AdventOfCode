require "utils"
-- La idea es utilizar los digitos para separar las puntuaciones y dar
-- una puntuación única a cada mano, incluyendo el desempate.
-- El primer dígito indica el tipo de mano, y a partir de ahi, cada dos digitos
-- es una puntuación 1-13 indicando el desempate de cada carta

local fiveOfAKind = 70000000000
local poker = 60000000000
local fullHouse = 50000000000
local threOfAKind = 40000000000
local twoPair = 30000000000
local pair = 20000000000
local highCard = 10000000000
local tiebreaker = {100000000, -- Desempate, Cada carta se multiplica por este valor
1000000, 10000, 100, 1}
local cardValue = {
    [1] = { -- Valores de cartas en parte 1
        ["A"] = 13,
        ["K"] = 12,
        ["Q"] = 11,
        ["J"] = 10,
        ["T"] = 9,
        ["9"] = 8,
        ["8"] = 7,
        ["7"] = 6,
        ["6"] = 5,
        ["5"] = 4,
        ["4"] = 3,
        ["3"] = 2,
        ["2"] = 1
    },
    [2] = { -- Valores de cartas en parte 2
        ["A"] = 13,
        ["K"] = 12,
        ["Q"] = 11,
        ["T"] = 10,
        ["9"] = 9,
        ["8"] = 8,
        ["7"] = 7,
        ["6"] = 6,
        ["5"] = 5,
        ["4"] = 4,
        ["3"] = 3,
        ["2"] = 2,
        ["J"] = 1
    }
}

local function getStrength(hand, part)
    local strength = 0
    local reps = {}
    local highCardType = "2"
    local jokers = 0
    if part == 2 then
        highCardType = "J"
    end
    for i = 1, #hand do
        local char = hand:sub(i, i)
        if char == "J" and part == 2 then
            jokers = jokers + 1
        end
        -- Desempate: Sumamos el valor de cada carta segun el orden
        strength = strength + cardValue[part][char] * tiebreaker[i]
        -- Registramos la carta mas alta highCard
        if cardValue[part][char] > cardValue[part][highCardType] then
            highCardType = char
        end
        -- Contamos las repeticiones para determinar el tipo de mano
        if part == 1 then
            if reps[char] == nil then
                reps[char] = 1
            else
                reps[char] = reps[char] + 1
            end
        elseif part == 2 and char ~= "J" then
            if reps[char] == nil then
                reps[char] = 1
            else
                reps[char] = reps[char] + 1
            end
        end
    end
    local sorted = {} -- ordeno las repeticiones de mayor a menor para identificar la mano facilmente
    for _, rep in pairs(reps) do
        table.insert(sorted, rep)
    end
    table.sort(sorted, function(a, b)
        return a > b
    end)
    -- esto puede suceder en la segunda parte ya que no tomo en cuenta los jokers
    if sorted[1] == nil then
        sorted[1] = 0
    end
    if sorted[2] == nil then
        sorted[2] = 0
    end
    -- identifico el tipo de mano y doy puntuación
    if sorted[1] + jokers == 5 then
        strength = strength + fiveOfAKind
    elseif sorted[1] + jokers == 4 then
        strength = strength + poker
    elseif sorted[1] + jokers == 3 and sorted[2] == 2 then
        strength = strength + fullHouse
    elseif sorted[1] + jokers == 3 then
        strength = strength + threOfAKind
    elseif sorted[1] == 2 and sorted[2] + jokers == 2 then
        strength = strength + twoPair
    elseif sorted[1] + jokers == 2 then
        strength = strength + pair
    else
        strength = strength + highCard
    end

    return strength
end

local function getInput(part)
    local input = readFile("07.input")
    local hands = {}
    local lines = splitString(input, lineDelimiter)
    for _, line in ipairs(lines) do
        line = splitString(line, spaceDelimiter)
        table.insert(hands, {
            hand = line[1],
            bid = line[2],
            strength = getStrength(line[1], part)
        })
    end
    return hands
end

local function getTotal(hands)
    local bestI = 1
    local minStrength = 99999999999999999
    local rank = 1
    local total = 0
    while #hands > 0 do
        minStrength = 99999999999999999
        for i, hand in ipairs(hands) do
            if minStrength > hand.strength then
                minStrength = hand.strength
                bestI = i
            end
        end
        -- print("rank: " .. rank, "hand: " .. hands[bestI].hand, "bid: " .. hands[bestI].bid,
        --    "winnings: " .. hands[bestI].bid * rank)
        total = total + (hands[bestI].bid * rank)
        rank = rank + 1
        table.remove(hands, bestI)
    end
    return total
end

local function answer1()
    local hands = getInput(1)

    return getTotal(hands)
end

local function answer2()
    local hands = getInput(2)
    return getTotal(hands)
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
