require "utils"

local function getInput()
    local input = readFile("12.input")
    local lines = splitString(input, lineDelimiter)
    local rows = {}
    local springs = ""
    local pattern = {}
    for _, line in ipairs(lines) do
        line = splitString(line, spaceDelimiter)
        springs = line[1]:gsub("[.]+", ".")
        pattern = splitString(line[2], commaDelimiter)
        for i = 1, #pattern do
            pattern[i] = tonumber(pattern[i])
        end
        table.insert(rows, {
            springs = springs,
            pattern = pattern
        })
    end
    return rows
end

local function countArrangements(springs, pattern, phase, hashtags)
    if #springs == 0 then
        if pattern[phase] == hashtags and phase == #pattern then
            return 1 -- Si al finalizar la cadena, no encuentra errores, la combinación es correcta
        end
        return 0 -- Se puede podar porque no cumple los requerimentos
    end
    local count = 0
    local char = string.sub(springs, 1, 1)

    if char == "." then
        if hashtags == 0 then
            count = count + countArrangements(springs:sub(2), pattern, phase, 0)
        elseif pattern[phase] == hashtags and phase < #pattern then
            count = count + countArrangements(springs:sub(2), pattern, phase + 1, 0)
        elseif hashtags == pattern[phase] and phase == #pattern then
            count = count + countArrangements(springs:sub(2), pattern, phase, hashtags)
        else
            return 0 -- Se puede podar porque no cumple los requerimentos
        end
    elseif char == "?" then
        count = count + countArrangements(replaceChar(springs, "#", 1), pattern, phase, hashtags)
        count = count + countArrangements(replaceChar(springs, ".", 1), pattern, phase, hashtags)
    elseif char == "#" then
        if hashtags < pattern[phase] then
            count = count + countArrangements(springs:sub(2), pattern, phase, hashtags + 1)
        else
            return 0 -- Se puede podar porque no cumple los requerimentos
        end
    end
    return count
end

local function answer1()
    local rows = getInput()
    local total = 0
    for _, row in ipairs(rows) do
        total = total + countArrangements(row.springs, row.pattern, 1, 0)
    end
    return total
end
print("Parte 1:", answer1())
