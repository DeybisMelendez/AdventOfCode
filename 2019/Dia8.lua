local file = io.open("Dia8.txt", "r") -- Se requiere un archivo Dia8.txt para ejecutar
local text = file:read("*a")
file:close()

local function get1by2digits(str)
    local one = 0
    local two = 0
    for char=1, str:len() do
        local c = str:sub(char, char)
        if c == "1" then
            one = one + 1
        elseif c == "2" then
            two = two + 1
        end
    end
    return one * two
end

local function result1(str, digit, width, height)
    local layers = {}
    local result = 0
    for layer=0, str:len()/(width*height)-1 do
        table.insert(layers, str:sub((width*height*layer)+1, width*height*(layer+1)))
    end
    local totalDigits
    for i, layer in ipairs(layers) do
        local layerDigits = 0
        for char=1, layer:len() do
            if layer:sub(char, char) == digit then
                layerDigits = layerDigits + 1
            end
        end
        if totalDigits==nil or totalDigits >= layerDigits then
            totalDigits = layerDigits
            result = get1by2digits(layer)
        end
    end
    return result
end
print("the answer 1 is:",result1(text,"0",25,6))