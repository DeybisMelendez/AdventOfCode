local input = {284639,748759}
local num = input[2] - input[1]
local passwords = {}
local passwords2 = {}

local function isCorrect(pass)
    local result = false
    -- Revisar numeros adyacentes
    local text = tostring(pass)
    for char=1, text:len()-1 do
        if tonumber(text:sub(char+1, char+1)) == tonumber(text:sub(char, char)) then
            result = true
            break
        end
    end
    if not result then return result end
    --result = false
    for char=1, text:len()-1 do
        if tonumber(text:sub(char+1, char+1)) < tonumber(text:sub(char, char)) then
            result = false
            break
        end
    end
    return result
end
local function isCorrect2(pass)
    local result = isCorrect(pass)
    local text = tostring(pass)
    -- for char=1, text:len()-4, 2 do
    --     if text:sub(char) == text:sub(char+1) and text:sub(char+2) == text:sub(char+3) then
    --         if tonumber(text:sub(char+2, char+3)) == tonumber(text:sub(char, char+1)) then
    --             result = false
    --             break
    --         end
    --     end
    -- end
    -- if not result then return result end
    for char=1, text:len()-4, 2 do
        if text:sub(char) == text:sub(char+1) and text:sub(char+2) == text:sub(char+3) then
            if tonumber(text:sub(char+2, char+3)) < tonumber(text:sub(char, char+1)) then
                result = false
                break
            end
        end
    end
    return result
end
for value=1, num do
    local pass = value + input[1]
    if isCorrect(pass) then
        table.insert(passwords, pass)
    end
end
for value=1, num do
    local pass = value + input[1]
    if isCorrect2(pass) then
        table.insert(passwords2, pass)
    end
end
print("the answer 1 is " .. #passwords)
print("the answer 2 is " .. #passwords2)
