-- readFile permite leer un archivo externo
function readFile(file)
    local file = io.open(file, "r")
    local input = file:read("*a")
    file:close()
    return input
end

-- split permite dividir un texto en un array con un delimitador
function splitString(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end