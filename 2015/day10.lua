local input = "1321131112"
local sub = string.sub
local match = string.gmatch
local function speak(num)
    local result = ""
    local char = sub(num,1,1)
    local count = 0
    --local i = 1
    --while i <= #num do
    --    local c = sub(num, i,i)
    for c in match(num,".") do
        if char == c then
            count = count + 1
        else
            result = result .. count .. char
            char = c
            count = 1
        end
        --i = i + 1
    end
        result = result .. count .. char
    return result
end

local function lookAndSay(val, num)
    for i=1, val do
        print(i)
        num = speak(num)
    end
    return num
end

print(#lookAndSay(40,input))
print(#lookAndSay(50,input)) --answer 2 is too slow