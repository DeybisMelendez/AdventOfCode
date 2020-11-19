local input = "1321131112"

local function lookAndSay(val, num)
    local result = ""
    for _=1, val do
        result = ""
        local actualChar
        local countChar = 0
        for i=1, #num do
            local a = string.sub(num, i, i)
            if actualChar == nil then
                actualChar = a
                countChar = 1
            elseif actualChar == a then
                countChar = countChar + 1
            else
                result = result .. countChar .. actualChar
                actualChar = a
                countChar = 1
            end
        end
        if  not (actualChar == nil) then
            result = result .. countChar .. actualChar
        end
        num = result
    end
    return result
end
local function answer1(str)
    return #lookAndSay(40,str)
end

print(answer1(input))