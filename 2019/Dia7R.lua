local inputCode = {
3,8,1001,8,10,8,105,1,0,0,21,38,63,72,81,106,187,268,349,430,99999,3,9,101,5,9,9,1002,9,3,9,101,3,9,9,4,9,99,3,9,102,3,9,9,101,4,9,9,1002,9,2,9,1001,9,2,9,1002,9,4,9,4,9,99,3,9,1001,9,3,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,4,9,9,1001,9,2,9,1002,9,5,9,1001,9,2,9,102,3,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99
--3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0
--3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5 --segunda parte
}
local function getSequences(n,m)
    local sequences = {}
    for a = n, m do
        for b = n, m do
            if not(a==b) then
                for c = n, m do
                    if not(a==c) and not(b==c) then
                        for d = n, m do
                            if not(a==d) and not(b==d) and not(c==d) then
                                for e = n, m do
                                    if not(a==e) and not(b==e) and not(c==e) and not(d==e) then
                                        table.insert(sequences, {a,b,c,d,e})
                                        --print(tostring(a) .. tostring(b) .. tostring(c) .. tostring(d) .. tostring(e))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return sequences
end

local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end

local IntCode = require "IntCode"

local function getResult1(n, m)
    local sequences = getSequences(n, m)
    local result = 0
    for _, v in ipairs(sequences) do
        local inputValue = 0
        for i=1, #v do
            local amp = IntCode:new(copyTable(inputCode))
            inputValue = amp:run({v[i], inputValue})
        end
        if result < inputValue then
            result = inputValue
        end
    end
    return result
end


local function getResult2(n, m)
    local sequences = getSequences(n,m)--{{9,8,7,6,5}}--
    local result = 0
    for _, v in ipairs(sequences) do
        local amps = {}
        local inputValue = 0
        for i=1, #v do
            table.insert(amps, IntCode:new(copyTable(inputCode)))
			inputValue = amps[i]:run({v[i], inputValue})
        end
        local done = false
        local output
        while not done do
            for i=1, #v do
                if inputValue == nil then break end
                output = inputValue
                inputValue = amps[i]:run({inputValue})
            end
            if inputValue == nil then done = true end
        end
        if result < output then
            result = output
        end
    end
    return result
end

print("the answer 1 is: " .. getResult1(0,4))
print("the answer 2 is: " .. getResult2(5,9))