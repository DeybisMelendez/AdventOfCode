require "utils"

local dir = {
    R = 2,
    L = 1
}

local LAST_CHAR<const> = 3

local function getInput()
    local input = readFile("08.input"):gsub("%(", ""):gsub("%)", ""):gsub("%,", "")
    local lines = splitString(input, lineDelimiter)
    local map = {}
    for i, line in ipairs(lines) do
        if i == 1 then
            map.ins = line -- Instrucciones
        end
        if i >= 2 then
            line = splitString(line, spaceDelimiter)
            map[line[1]] = {line[3], line[4]}
        end
    end
    return map
end

local function answer1()
    local map = getInput()
    local node = "AAA"
    local count = 0
    local index = 1
    while node ~= "ZZZ" do
        node = map[node][dir[string.sub(map.ins, index, index)]]
        index = index + 1
        if index > #map.ins then
            index = 1
        end
        count = count + 1
    end
    return count
end

local function answer2()
    local map = getInput()
    local count = 0
    local index = 1
    local nodes = {}
    local isNodeCorrect = false
    local solution = 1
    for node, _ in pairs(map) do
        if string.sub(node, LAST_CHAR, LAST_CHAR) == "A" then
            table.insert(nodes, node)
        end
    end
    for i, node in ipairs(nodes) do
        isNodeCorrect = false
        count = 0
        while not isNodeCorrect do
            isNodeCorrect = true
            node = map[node][dir[string.sub(map.ins, index, index)]]
            if string.sub(node, LAST_CHAR, LAST_CHAR) ~= "Z" then
                isNodeCorrect = false
            end
            index = index + 1
            if index > #map.ins then
                index = 1
            end
            count = count + 1
        end
        solution = LCM(count, solution) -- Minimo Comun Multiplo LCM
    end
    return solution
end

print("Parte 1:", answer1())
print("Parte 2:", answer2())
