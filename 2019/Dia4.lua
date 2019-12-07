local input = {284639,748759} -- Escribir rango de numeros
local num = input[2] - input[1]
local passwords = {}
local passwords2 = {}

local function are2AdjacentNumberTheSame(pass)
    for char=1, pass:len()-1 do
        if pass:sub(char, char) == pass:sub(char+1, char+1) then
            return true
        end
    end
    return false
end

local function digitsNeverDecrease(pass)
    for char=1, pass:len()-1 do
        if pass:sub(char+1, char+1) < pass:sub(char, char) then
            return false
        end
    end
    return true
end

local function areNotPartOfALargerGroupOfMatchingDigits(pass)
    for char=1, pass:len()-3,2 do
        if not (pass:sub(char, char+1) >= pass:sub(char+2, char+3)) then
            return false
        end
    end
    return true
end
for value=1, num do
    local pass = value + input[1]
    if are2AdjacentNumberTheSame(tostring(pass)) and digitsNeverDecrease(tostring(pass)) then
        table.insert(passwords, pass)
        if areNotPartOfALargerGroupOfMatchingDigits(tostring(pass)) then
            table.insert(passwords2, pass)
        end
    end
end
print("the answer 1 is " .. #passwords)
print("the answer 2 is " .. #passwords2)
for _, pass in ipairs(passwords2) do
    print(pass)
end
