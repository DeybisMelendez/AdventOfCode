local input = {284639,748759} -- Escribir rango de numeros
local answer1 = 0
local answer2 = 0
print("total pass: " .. input[2]-input[1])
for pass = input[1], input[2] do
    local text = tostring(pass)
    local sameDigits = false
    local neverDecrease = true
    local isOnlyPair = false
    for char=1, 5 do
        if text:sub(char, char) == text:sub(char+1, char+1) then
            sameDigits = true
            if not (text:sub(char, char) == text:sub(char-1, char-1) or
                    text:sub(char, char) == text:sub(char+2, char+2)) then
                isOnlyPair = true
            end
        end
        if text:sub(char+1, char+1) < text:sub(char, char) then
            neverDecrease = false
        end
    end
    if sameDigits and neverDecrease then answer1 = answer1 + 1 end
    if sameDigits and neverDecrease and isOnlyPair then answer2 = answer2 + 1 end
end
print("answer 1: " .. answer1)
print("answer 2: " .. answer2)
