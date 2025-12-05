local batteries = "987654321111111"
math.randomseed(os.time())

local function getRandomJoltage(batteries)

    local currentIndex = 1
    local targetIndex = 12
    while currentIndex <= #batteries and targetIndex > 0 do
        local remainingChars = #batteries - currentIndex + 1
        if remainingChars == targetIndex then
            break
        end
        local takeChar = math.random() < (targetIndex / remainingChars)
        if takeChar then
            targetIndex = targetIndex - 1
        end
        currentIndex = currentIndex + 1
    end


    local available = {}
    for i = 1, #batteries do
        available[i] = i
    end

    local chosen = {}

    -- Elegir 12 índices sin repetir
    for i = 1, 12 do
        local j = math.random(1, #available)
        table.insert(chosen, available[j])
        table.remove(available, j)
    end

    -- ORDENAR los índices elegidos
    table.sort(chosen)

    -- Construir el número en orden
    local joltage = ""
    for _, idx in ipairs(chosen) do
        joltage = joltage .. batteries:sub(idx, idx)
    end

    return joltage
end

local maxJoltage = 0
while true do
    local joltage = getRandomJoltage(batteries)
    if tonumber(joltage) > maxJoltage then
        maxJoltage = tonumber(joltage)
        print("New max joltage: " .. joltage)
    end
end