require "utils"

local OP<const> = {
    EQUAL = 1,
    MINUS = 2
}

local function getInput()
    local input = readFile("15.input")
    return splitString(input, commaDelimiter)
end

local function getHash(str)
    local hash = 0
    for i = 1, #str do
        hash = hash + string.byte(str, i)
        hash = hash * 17
        hash = hash % 256
    end
    return hash
end

local function getLenInfo(str)
    local x = string.find(str, "=") -- si no se encuentra = es -
    local op = -1
    local label = ""
    local box = -1
    local number = -1
    if x == nil then -- "la operación es -"
        op = OP.MINUS
        label = string.sub(str, 1, -2)
        box = getHash(label)
        number = -1
    else
        op = OP.EQUAL
        label = string.sub(str, 1, -3)
        box = getHash(label)
        number = tonumber(string.sub(str, -1))
    end
    return {
        op = op,
        label = label,
        box = box,
        number = number
    }
end

local function answer1()
    local input = getInput()
    local total = 0
    for _, str in ipairs(input) do
        total = total + getHash(str)
    end
    return total
end

local function answer2()
    local input = getInput()
    local boxes = {}
    local lenInfo = {}
    local total = 0
    local hasLabel = false
    for i = 0, 255 do
        boxes[i] = {}
    end

    for _, str in ipairs(input) do
        lenInfo = getLenInfo(str)
        if lenInfo.op == OP.EQUAL then
            hasLabel = false
            for i = 1, #boxes[lenInfo.box] do
                if boxes[lenInfo.box][i].label == lenInfo.label then
                    boxes[lenInfo.box][i].number = lenInfo.number
                    hasLabel = true
                    break
                end
            end
            if not hasLabel then
                table.insert(boxes[lenInfo.box], {
                    label = lenInfo.label,
                    number = lenInfo.number
                })
            end
        elseif lenInfo.op == OP.MINUS then
            for i = 1, #boxes[lenInfo.box] do
                if boxes[lenInfo.box][i].label == lenInfo.label then
                    table.remove(boxes[lenInfo.box], i)
                    break
                end
            end
        end
    end
    for i = 0, #boxes do
        if #boxes[i] > 0 then
            for j, box in ipairs(boxes[i]) do
                total = total + (i + 1) * j * box.number
            end
        end
    end
    return total
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
