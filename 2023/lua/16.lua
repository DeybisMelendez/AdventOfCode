require "utils"

local DIR<const> = {
    LEFT = 1,
    UP = 2,
    RIGHT = 3,
    DOWN = 4,
    NULL = -1
}

local function getInput()
    local input = readFile("16.input")
    local lines = splitString(input, lineDelimiter)
    local map = {}
    for i, line in ipairs(lines) do
        line = splitString(line, charDelimiter)
        map[i] = line
    end
    return map
end

local function createCellularAutomaton(x, y, dir)
    local Automata = {
        pos = {
            x = x,
            y = y
        },
        dir = dir
    }
    function Automata.move(map, energyMap)
        local newPos = {
            x = Automata.pos.x,
            y = Automata.pos.y
        }
        -- Visualización
        --[[os.execute("clear")
        print("position: " .. Automata.pos.x .. ", " .. Automata.pos.y)
        for i = Automata.pos.y - 15, Automata.pos.y + 16 do
            if i > 0 and i <= #map then
                for j = Automata.pos.x - 31, Automata.pos.x + 32 do
                    if j > 0 and j <= #map[1] then
                        if i == Automata.pos.y and j == Automata.pos.x then
                            io.write("@")
                        elseif energyMap[i][j] == DIR.NULL then
                            io.write(".")
                        elseif energyMap[i][j] == DIR.DOWN then
                            io.write("V")
                        elseif energyMap[i][j] == DIR.UP then
                            io.write("A")
                        elseif energyMap[i][j] == DIR.RIGHT then
                            io.write(">")
                        elseif energyMap[i][j] == DIR.LEFT then
                            io.write("<")
                        end
                    end
                end
            end
            io.write("\n")
        end
        os.execute("sleep 0.01")]]
        -- si nunca se ha visitado, entonces guardamos la dirección para evaluar luego si ya viajamos por ahi
        if energyMap[Automata.pos.y][Automata.pos.x] == DIR.NULL then
            energyMap[Automata.pos.y][Automata.pos.x] = Automata.dir
        elseif energyMap[Automata.pos.y][Automata.pos.x] == Automata.dir then
            return
        end
        if Automata.dir == DIR.LEFT then
            newPos.x = newPos.x - 1
        elseif Automata.dir == DIR.RIGHT then
            newPos.x = newPos.x + 1
        elseif Automata.dir == DIR.UP then
            newPos.y = newPos.y - 1
        elseif Automata.dir == DIR.DOWN then
            newPos.y = newPos.y + 1
        end
        if newPos.y > 0 and newPos.y <= #map and newPos.x > 0 and newPos.x <= #map[1] then

            local nextCell = map[newPos.y][newPos.x]
            if nextCell == "." then
                Automata.pos.x = newPos.x
                Automata.pos.y = newPos.y
                Automata.move(map, energyMap)
            elseif nextCell == "/" then
                if Automata.dir == DIR.DOWN then
                    Automata.dir = DIR.LEFT
                elseif Automata.dir == DIR.RIGHT then
                    Automata.dir = DIR.UP
                elseif Automata.dir == DIR.UP then
                    Automata.dir = DIR.RIGHT
                elseif Automata.dir == DIR.LEFT then
                    Automata.dir = DIR.DOWN
                end
                Automata.pos.x = newPos.x
                Automata.pos.y = newPos.y
                Automata.move(map, energyMap)
            elseif nextCell == "\\" then -- el caracter es \ pero requiere un escape de caracter
                if Automata.dir == DIR.DOWN then
                    Automata.dir = DIR.RIGHT
                elseif Automata.dir == DIR.RIGHT then
                    Automata.dir = DIR.DOWN
                elseif Automata.dir == DIR.UP then
                    Automata.dir = DIR.LEFT
                elseif Automata.dir == DIR.LEFT then
                    Automata.dir = DIR.UP
                end
                Automata.pos.x = newPos.x
                Automata.pos.y = newPos.y
                Automata.move(map, energyMap)
            elseif nextCell == "-" then
                if Automata.dir == DIR.DOWN or Automata.dir == DIR.UP then
                    local cellularToLeft = createCellularAutomaton(newPos.x, newPos.y, DIR.LEFT)
                    cellularToLeft.move(map, energyMap)
                    local cellularToRight = createCellularAutomaton(newPos.x, newPos.y, DIR.RIGHT)
                    cellularToRight.move(map, energyMap)
                else
                    Automata.pos.x = newPos.x
                    Automata.pos.y = newPos.y
                    Automata.move(map, energyMap)
                end
            elseif nextCell == "|" then
                if Automata.dir == DIR.LEFT or Automata.dir == DIR.RIGHT then
                    local cellularToDOWN = createCellularAutomaton(newPos.x, newPos.y, DIR.DOWN)
                    cellularToDOWN.move(map, energyMap)
                    local cellularToUp = createCellularAutomaton(newPos.x, newPos.y, DIR.UP)
                    cellularToUp.move(map, energyMap)
                else
                    Automata.pos.x = newPos.x
                    Automata.pos.y = newPos.y
                    Automata.move(map, energyMap)
                end
            end
        end
    end
    return Automata
end

local function newEnergyMap(map)
    local energyMap = {}
    for i, rank in ipairs(map) do
        energyMap[i] = {}
        for j, _ in ipairs(rank) do
            energyMap[i][j] = -1
        end
    end
    return energyMap
end

local function getTotalEnergy(energyMap)
    local total = 0
    for _, rank in ipairs(energyMap) do
        for _, val in ipairs(rank) do
            if val ~= DIR.NULL then
                total = total + 1
            end
        end
    end
    return total
end

local function answer1()
    local map = getInput()
    local energyMap = newEnergyMap(map)
    local cellular = createCellularAutomaton(1, 1, DIR.DOWN)
    cellular.move(map, energyMap)
    return getTotalEnergy(energyMap)
end

local function answer2()
    local map = getInput()
    local energyMap = {}
    local bestTotal = 0
    local total = 0
    for x = 1, #map[1] do
        energyMap = newEnergyMap(map)
        local cellular = createCellularAutomaton(x, 1, DIR.DOWN)
        cellular.move(map, energyMap)
        total = getTotalEnergy(energyMap)
        if total > bestTotal then
            bestTotal = total
        end
        energyMap = newEnergyMap(map)
        cellular = createCellularAutomaton(x, #map, DIR.UP)
        cellular.move(map, energyMap)
        total = getTotalEnergy(energyMap)
        if total > bestTotal then
            bestTotal = total
        end
    end
    for y = 1, #map do
        energyMap = newEnergyMap(map)
        local cellular = createCellularAutomaton(1, y, DIR.RIGHT)
        cellular.move(map, energyMap)
        total = getTotalEnergy(energyMap)
        if total > bestTotal then
            bestTotal = total
        end
        energyMap = newEnergyMap(map)
        cellular = createCellularAutomaton(#map, y, DIR.LEFT)
        cellular.move(map, energyMap)
        total = getTotalEnergy(energyMap)
        if total > bestTotal then
            bestTotal = total
        end
    end
    return bestTotal
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
