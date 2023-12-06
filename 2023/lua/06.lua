require "utils"

local function getInput()
    local input = readFile("06.input")
    local lines = splitString(input, lineDelimiter)
    local times = splitString(lines[1], spaceDelimiter)
    local distances = splitString(lines[2], spaceDelimiter)
    local races = {}
    for i = 2, #times do
        table.insert(races, {
            time = tonumber(times[i]),
            distance = tonumber(distances[i])
        })
    end
    return races
end

local function calcDistance(holded, time)
    return (time - holded) * holded
end

local function answer1()
    local races = getInput()
    local waysCouldWin = 0
    local total = 1 -- Se multiplica por 1
    for _, race in ipairs(races) do
        waysCouldWin = 0
        -- no iniciar desde cero porque no se movería nada
        -- tampoco vale la pena evaluar si se queda el botón presionado todo el tiempo
        for i = 1, race.time - 1 do
            if calcDistance(i, race.time) > race.distance then
                waysCouldWin = waysCouldWin + 1
            end
        end
        total = total * waysCouldWin
    end
    return total
end

print("Parte 1:", answer1())
-- Para la parte 2 lo mas facil es eliminar los espacios manualmente y tarda pocos milisegundos en resolverlo
