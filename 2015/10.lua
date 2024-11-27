local input = "1321131112"
local lookAndSayMemo = {}

local function nextLookAndSay(term)
    local result = {}
    local count = 1

    for i = 2, #term do
        if term:sub(i, i) == term:sub(i - 1, i - 1) then
            count = count + 1
        else
            table.insert(result, tostring(count) .. term:sub(i - 1, i - 1))
            count = 1
        end
    end

    table.insert(result, tostring(count) .. term:sub(#term, #term))

    return table.concat(result)
end

local function calcLookAndSay(start, n)
    lookAndSayMemo[1] = start

    for i = 2, n + 1 do
        if not lookAndSayMemo[i] then
            lookAndSayMemo[i] = nextLookAndSay(lookAndSayMemo[i - 1])
        end
    end

    return #lookAndSayMemo[n + 1]
end

local function answer1()
    return calcLookAndSay(input, 40)
end

local function answer2()
    return calcLookAndSay(input, 50)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
