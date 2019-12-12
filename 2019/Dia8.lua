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

local function getLayers(str, width, height)
    local t = {}
    for layer=0, str:len() / (width * height) - 1 do
        table.insert(t, str:sub((width * height * layer) + 1, width * height * (layer + 1)))
    end
    return t
end

local function result1(str, digit, width, height)
    local layers = getLayers(str, width, height)
    local result = 0

    local totalDigits
    for _, layer in ipairs(layers) do
        local layerDigits = 0
        for char=1, layer:len() do
            if layer:sub(char, char) == digit then
                layerDigits = layerDigits + 1
            end
        end
        if totalDigits == nil or totalDigits >= layerDigits then
            totalDigits = layerDigits
            result = get1by2digits(layer)
        end
    end
    print(#layers)
    return result
end

local function result2(str, width, height)
    local layers = getLayers(str, width, height)
    local result = {}
    local newStr = ""
    for char=1, layers[1]:len() do

        for _, layer in ipairs(layers) do
            if not result[char] then
                result[char] = layer:sub(char,char)
            elseif tonumber(result[char]) == 2 then
                result[char] = layer:sub(char,char)
            end
        end
    end
    local line = 25
    for index, char in ipairs(result) do
        if index > line then
            newStr = newStr .. "\n"
            line = line + 25
        end
        newStr = newStr .. char
    end
    return newStr
end

print("the answer 1 is:",result1(text,"0",25,6))
print("the answer 2 is: \n" .. result2(text, 25, 6))