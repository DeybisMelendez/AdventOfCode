local file = io.open("Dia1.txt", "r") -- Se requiere un archivo Dia1.txt para ejecutar
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local inputCode = split(text, "[^\n]+")

local function fuelRequeriment(mass)
    return math.floor(mass/3)-2
end

local function totalFuelRequeriment(mass)
    local total = 0
    local newMass = mass
    while fuelRequeriment(newMass) > 0 do
        newMass = fuelRequeriment(newMass)
        total = total + newMass
    end
    return total
end

local function getFuelRequeriment(input, addFuel)
    local total = 0
    for _, mass in ipairs(input) do
        if addFuel then
            total = total + totalFuelRequeriment(mass)
        else
            total = total + fuelRequeriment(mass)
        end
    end
    return total
end

print("the answer 1 is: " .. getFuelRequeriment(inputCode))
print("the answer 2 is: " .. getFuelRequeriment(inputCode, true))