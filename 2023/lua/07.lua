require "utils"
-- La idea es utilizar los digitos para separar las puntuaciones y dar
-- una puntuación única a cada mano, incluyendo el desempate.
-- los primeros 2 ceros mas altos puntuan el tipo de carta que forma parte el tipo de mano 1-13.
-- Los siguientes 4 ceros puntuan la diferencia en fullHouse y dos pares,primeros 2 para el mas alto,
-- y los otros 2 para el segundo mas alto.
-- Esto debido a que hay combinaciones de fullHouse y dos pares que deben una puntuación única.
-- luego cada 2 ceros en adelante puntuan los desempates por cartas
local fiveOfAKind = 70000000000000000
local poker = 60000000000000000
local fullHouse = 50000000000000000 -- 156 combinaciones posibles de fullHouse
local threOfAKind = 40000000000000000
local twoPair = 30000000000000000 -- 156 combinaciones posibles de dos pares
local pair = 20000000000000000
local highCard = 10000000000000000
local typeCardValue = 100000000000000
local tiebreaker = {100000000, -- Desempate, Cada carta se multiplica por este valor
1000000, 10000, 100, 1}
local firstHighValue = 1000000000000 -- para dar valor en fullhouse y dos pares
local secondHighValue = 10000000000 -- para dar valor en fullhouse y dos pares
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
    local typeCard1 = ""
    local typeCard2 = ""
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
            typeCard1 = char
        elseif rep == 4 then
            -- Poker
            isPoker = true
            typeCard1 = char
        elseif rep == 3 then
            -- Three Of A Kind
            isThreeOfAKind = true
            typeCard1 = char
        elseif rep == 2 then
            -- Pair
            if not isOnePair then
                isOnePair = true
                typeCard2 = char -- necesario para no borrar la carta en caso de fullhouse
            else -- Two Pair
                isTwoPair = true
                typeCard1 = char
            end
        end
    end

    -- Verificamos si es full house
    if isThreeOfAKind and isOnePair then
        isFullHouse = true
    end
    -- Puntuamos en orden de tipo
    if isFiveOfAKind then
        strength = strength + fiveOfAKind -- + (typeCardValue * cardValue[typeCard1])
    elseif isPoker then
        strength = strength + poker -- + (typeCardValue * cardValue[typeCard1])
    elseif isFullHouse then
        strength = strength + fullHouse -- + (firstHighValue * cardValue[typeCard1]) +
        -- (secondHighValue * cardValue[typeCard2])
    elseif isThreeOfAKind then
        strength = strength + threOfAKind -- + (typeCardValue * cardValue[typeCard1])
    elseif isTwoPair then
        strength = strength + twoPair
        --[[if cardValue[typeCard1] > cardValue[typeCard2] then
            strength = strength -- + (firstHighValue * cardValue[typeCard1]) + (secondHighValue * cardValue[typeCard2])
        else
            strength = strength -- + (secondHighValue * cardValue[typeCard1]) + (firstHighValue * cardValue[typeCard2])
        end--]]
    elseif isOnePair then
        strength = strength + pair -- + (typeCardValue * cardValue[typeCard2])
    else
        strength = strength + highCard -- + (typeCardValue * cardValue[highCardType])
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
        print("rank: " .. rank, "hand: " .. hands[bestI].hand, "bid: " .. hands[bestI].bid,
            "winnings: " .. hands[bestI].bid * rank)
        total = total + (hands[bestI].bid * rank)
        rank = rank + 1
        table.remove(hands, bestI)
    end
    return total
end

print("Parte 1:", answer1())
