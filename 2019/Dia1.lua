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

local getTotalFuelRequeriment(input)
    local total = 0
    for _, mass in ipairs(input) do
        total = total + fuelRequeriment(mass)
    end
    return total
end

print("the answer 1 is: " .. getTotalFuelRequeriment(inputCode))