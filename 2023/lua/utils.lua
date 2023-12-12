lineDelimiter = "[^\n]+" -- Delimitador de lineas
commaDelimiter = "[^,]+" -- Delimitador de comas
spaceDelimiter = "[^%s]+" -- Delimitador de espacios
semiColonDelimiter = "[^;]+" -- Delimitador de punto y coma
colonDelimiter = "[^:]+"
charDelimiter = "."

matchNumber = "%d+" -- devuelve un numero de un string con match
-- readFile permite leer un archivo externo
function readFile(file)
    local file = io.open(file, "r")
    local input = file:read("*a")
    file:close()
    return input
end

-- split permite dividir un texto en un array con un delimitador
function splitString(str, del) -- String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end
-- contains verifica si una tabla contiene un elemento
function contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
-- Función para calcular el máximo común divisor (MCD)
function GCD(a, b)
    while b ~= 0 do
        a, b = b, a % b
    end
    return a
end

-- Función para calcular el mínimo común múltiplo (mcm)
function LCM(a, b)
    return (a * b) // GCD(a, b)
end

function tableConcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end
