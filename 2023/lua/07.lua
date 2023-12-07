require "utils"
-- La idea es utilizar los digitos para separar las puntuaciones y dar
-- una puntuación única a cada mano, incluyendo el desempate.
-- El primer dígito indica el tipo de mano, y a partir de ahi, cada dos digitos
-- es una puntuación 1-13 indicando el desempate de cada carta

local fiveOfAKind = 70000000000
local poker = 60000000000
local fullHouse = 50000000000 -- 156 combinaciones posibles de fullHouse
local threOfAKind = 40000000000
local twoPair = 30000000000 -- 156 combinaciones posibles de dos pares
local pair = 20000000000
local highCard = 10000000000
local tiebreaker = {100000000, -- Desempate, Cada carta se multiplica por este valor
1000000, 10000, 100, 1}
local cardValue = {
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
}

local function getStrength(hand)
    local strength = 0
    local reps = {}
    local isFiveOfAKind = false
    local isPoker = false
    local isFullHouse = false
    local isThreeOfAKind = false
    local isTwoPair = false
    local isOnePair = false
    local highCardType = "2"
    for i = 1, #hand do
        local char = hand:sub(i, i)
        -- Desempate: Sumamos el valor de cada carta segun el orden
        strength = strength + cardValue[char] * tiebreaker[i]
        -- Registramos la carta mas alta highCard
        if cardValue[char] > cardValue[highCardType] then
            highCardType = char
        end
        -- Contamos las repeticiones para determinar el tipo de mano
        if reps[char] == nil then
            reps[char] = 1
        else
            reps[char] = reps[char] + 1
        end
    end
    for char, rep in pairs(reps) do
        -- Evaluamos el tipo de mano
        if rep == 5 then
            -- Five Of A Kind
            isFiveOfAKind = true
        elseif rep == 4 then
            -- Poker
            isPoker = true
        elseif rep == 3 then
            -- Three Of A Kind
            isThreeOfAKind = true
        elseif rep == 2 then
            -- Pair
            if not isOnePair then
                isOnePair = true
            else -- Two Pair
                isTwoPair = true
            end
        end
    end

    -- Verificamos si es full house
    if isThreeOfAKind and isOnePair then
        isFullHouse = true
    end
    -- Puntuamos en orden de tipo
    if isFiveOfAKind then
        strength = strength + fiveOfAKind
    elseif isPoker then
        strength = strength + poker
    elseif isFullHouse then
        strength = strength + fullHouse
    elseif isThreeOfAKind then
        strength = strength + threOfAKind
    elseif isTwoPair then
        strength = strength + twoPair
    elseif isOnePair then
        strength = strength + pair
    else
        strength = strength + highCard
    end
    return strength
end

local function getInput()
    local input = readFile("07.input")
    local hands = {}
    local lines = splitString(input, lineDelimiter)
    for _, line in ipairs(lines) do
        line = splitString(line, spaceDelimiter)
        table.insert(hands, {
            hand = line[1],
            bid = line[2],
            strength = getStrength(line[1]) -- En base a la puntuación se puede ordenar, el rango sería el index
        })
    end
    return hands
end

local function answer1()
    local hands = getInput()
    local bestI = 1 -- en Lua se itera desde 1, no 0
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

print("Parte 1:", answer1())
