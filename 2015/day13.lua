require "utils"
local text = string.readFile("day13input.txt")

local function getInput(str)
    str = str:gsub(" would", "")
    str = str:gsub("happiness units by sitting next to ", "")
    str = str:gsub("%.", "")
    local people = {}
    local input = {}
    local split = string.split(str, "[^\n]+")
    for i,v in ipairs(split) do
        local t = string.split(v, "[^%s]+")
        local index = t[1]
        table.remove(t,1)
        if type(input[index]) == "table" then
            table.insert(input[index], t)
        else
            input[index] = {t}
        end
        if not table.contains(people, index) then
            table.insert(people, index)
        end
    end
    return input, table.permute(people)
end

local function totalHappiness(input, combs)
    local total = 0
    for _,v in ipairs(combs) do
        local newTotal = 0
        for i2,v2 in ipairs(v) do
            local next, back = i2+1,i2-1
            if next > #v then next = 1 end
            if back < 1 then back = #v end
            local right = v[next]
            local left = v[back]
            for _, v3 in ipairs(input[v2]) do
                    if v3[3] == right or v3[3] == left then
                        if v3[1] == "gain" then
                            newTotal = newTotal + v3[2]
                        elseif v3[1] == "lose" then
                            newTotal = newTotal - v3[2]
                        end
                    end
            end
        end
        if newTotal > total then
            total = newTotal
        end
    end
    return total
end

local function answer1(str)
    local input, combs = getInput(str)
    return totalHappiness(input, combs)
end

local function answer2(str)
    local me = [[

Damv would gain 0 happiness units by sitting next to Bob.
Damv would gain 0 happiness units by sitting next to Carol.
Damv would lose 0 happiness units by sitting next to David.
Damv would lose 0 happiness units by sitting next to Eric.
Damv would gain 0 happiness units by sitting next to Frank.
Damv would gain 0 happiness units by sitting next to George.
Damv would gain 0 happiness units by sitting next to Mallory.
Alice would gain 0 happiness units by sitting next to Damv.
Bob would gain 0 happiness units by sitting next to Damv.
Carol would gain 0 happiness units by sitting next to Damv.
David would gain 0 happiness units by sitting next to Damv.
Eric would gain 0 happiness units by sitting next to Damv.
Frank would gain 0 happiness units by sitting next to Damv.
George would gain 0 happiness units by sitting next to Damv.
Mallory would gain 0 happiness units by sitting next to Damv.]]
    str = str .. me
    print(str)
    local input, combs = getInput(str)
    return totalHappiness(input, combs)
end

print(answer1(text))
print(answer2(text))