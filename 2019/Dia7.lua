local inputCode = {
--3,8,1001,8,10,8,105,1,0,0,21,38,63,72,81,106,187,268,349,430,99999,3,9,101,5,9,9,1002,9,3,9,101,3,9,9,4,9,99,3,9,102,3,9,9,101,4,9,9,1002,9,2,9,1001,9,2,9,1002,9,4,9,4,9,99,3,9,1001,9,3,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,4,9,9,1001,9,2,9,1002,9,5,9,1001,9,2,9,102,3,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99
--3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0
3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5 --segunda parte
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

local function intCode(table, v)--iv)
    local input = copyTable(table)
    local pointer = v.p --Tablas en lua comienzan con 1, no 0
    local opCode
    local nextInput = v.n
    while true do
        local code = tostring(input[pointer])
        for _=1, 5-(code:len()) do
            code = "0" .. code
        end
        opCode = tonumber(code:sub(code:len()-1, code:len()))
        if opCode == 99 then return nil end --input[input[pointer+1]+1] end
        local param1, param2--, param3 parametro 3 tecnicamente no requiere modo inmediato
        if tonumber(code:sub(3,3)) == 1 then param1 = pointer+1 else param1 = input[pointer+1]+1 end
        if opCode ~= 4 and opCode ~= 3 then
            if tonumber(code:sub(2,2)) == 1 then param2 = pointer+2 else param2 = input[pointer+2]+1 end
        end
        if opCode == 1 then
            input[input[pointer+3]+1] = input[param1] + input[param2]
            pointer = pointer + 4
        elseif opCode == 2 then
            input[input[pointer+3]+1] = input[param1] * input[param2]
            pointer = pointer + 4
        -- nuevas instrucciones PARTE 1
        elseif opCode == 3 then
            input[input[pointer+1]+1] = i[nextInput] or i[2]--inputValue
            nextInput = nextInput+1
            input[nextInput] = nextInput
            pointer = pointer + 2
        elseif opCode == 4 then
            return input[input[pointer+1]+1], {p=pointer, n = nextInput}
            --pointer = pointer + 2
        -- Nuevas instrucciones PARTE 2
        elseif opCode == 5 then
            if not (input[param1] == 0) then pointer = input[param2]+1 else pointer = pointer + 3 end
        elseif opCode == 6 then
            if input[param1] == 0 then pointer = input[param2]+1 else pointer = pointer + 3 end
        elseif opCode == 7 then
            if input[param1] < input[param2] then input[input[pointer+3]+1] = 1 else input[input[pointer+3]+1] = 0 end
            pointer = pointer + 4
        elseif opCode == 8 then
            if input[param1] == input[param2] then input[input[pointer+3]+1] = 1 else input[input[pointer+3]+1] = 0 end
            pointer = pointer + 4
        else
            error("opCode desconocido: " .. opCode)
        end
        input["pointer"] = pointer
    end
end

local function getResult1()
    local sequences = getSequences(0,4)
    local result = 0
    for _, v in ipairs(sequences) do
        local inputValue = 0
        for inputInstruction=1, #v do
            inputValue = intCode(inputCode, {v[inputInstruction], inputValue})
        end
        if result < inputValue then
            result = inputValue
        end
    end
    return result
end

local function getResult2()
    local sequences = {{9,8,7,6,5}}--getSequences(5,9)
    --print("sequences ", #sequences)
    local result = 0
    for _, v in ipairs(sequences) do
        --local amps = {}
        local inputValue = 0
        local unfinish = true
        local amps = {}
        for _=1, 5 do
            table.insert(amps, {p=1,n=1})
        end
        while unfinish do
            --print(inputValue)
            for i=1, #v do
                --local t = amps[inputInstruction]
                inputValue, amps[i] = intCode(inputCode, {v[i], inputValue}, amps[i])
                if not inputValue then unfinish = false end
            end
            if result < inputValue then
                result = inputValue
            end
            --print(inputValue)
        end
    end
    return result
end

--print("the answer 1 is: " .. getResult1())
print("the answer 2 is: " .. getResult2())