local utils = {
    lineDelimiter = "[^\n]+",
    commaDelimiter = "[^,]+",
    spaceDelimiter = "[^%s]+",
    semiColonDelimiter = "[^;]+",
    colonDelimiter = "[^:]+",
    dotDelimiter = "[^.]+",
    charDelimiter = ".",
}

function utils.readFile(file)
    local file = io.open(file, "r")
    local text = file:read("*a")
    file:close()
    return text
end

function utils.split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

function utils.replaceChar(str, char, index)
    return str:sub(1, index - 1) .. char .. str:sub(index + 1)
end

return utils