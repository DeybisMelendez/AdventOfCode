local inputCode = {
3,8,1001,8,10,8,105,1,0,0,21,38,63,72,81,106,187,268,349,430,99999,3,9,101,5,9,9,1002,9,3,9,101,3,9,9,4,9,99,3,9,102,3,9,9,101,4,9,9,1002,9,2,9,1001,9,2,9,1002,9,4,9,4,9,99,3,9,1001,9,3,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,4,9,9,1001,9,2,9,1002,9,5,9,1001,9,2,9,102,3,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99
}
local output = 0

local sequences = {}
for a = 0, 4 do
    for b = 0, 4 do
        if not(a==b) then
            for c = 0, 4 do
                if not(a==c) and not(b==c) then
                    for d = 0, 4 do
                        if not(a==d) and not(b==d) and not(c==d) then
                            for e = 0, 4 do
                                if not(a==e) and not(b==e) and not(c==e) and not(d==e) then
                                    table.insert(sequences, {a,b,c,d,e})
                                    print(tostring(a) .. tostring(b) .. tostring(c) .. tostring(d) .. tostring(e))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end

local function intCode(i, iv)
    local input = copyTable(i)
    local pointer = 1 --Tablas en lua comienzan con 1, no 0
    local opCode
    while true do
        local code = tostring(input[pointer])
        --if code:sub(1, 1) ~= 0 then code = code:sub(1, 1) .. "0" .. code:sub(2, code:len()) end
        for _=1, 5-(code:len()) do
            code = "0" .. code
        end
        opCode = tonumber(code:sub(code:len()-1, code:len()))
        if opCode == 99 then return output, input end
        local param1, param2--, param3 parametro 3 tecnicamente no requiere modo inmediato
        if tonumber(code:sub(3,3)) == 1 then param1 = pointer+1 else param1 = input[pointer+1]+1 end
        if opCode ~= 4 and opCode ~= 3 then
            if tonumber(code:sub(2,2)) == 1 then param2 = pointer+2 else param2 = input[pointer+2]+1 end
        end
        -- if opCode ~= 4 and opCode ~= 3 and opCode ~= 5 and opCode ~= 6 then
        --     if tonumber(code:sub(1,1)) == 0 then param3 = input[pointer+3]+1 else param3 = pointer+3 end
        -- end
        if opCode == 1 then
            input[input[pointer+3]+1] = input[param1] + input[param2]
            pointer = pointer + 4
        elseif opCode == 2 then
            input[input[pointer+3]+1] = input[param1] * input[param2]
            pointer = pointer + 4
        -- nuevas instrucciones PARTE 1
        elseif opCode == 3 then
            input[input[pointer+1]+1] = iv--inputValue
            pointer = pointer + 2
        elseif opCode == 4 then
            output = input[input[pointer+1]+1]
            pointer = pointer + 2
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
            return "error, pointer: " .. pointer .. ", opcode: " .. opCode .. ", output " .. output .. ", code " .. code .. ", value " .. input[pointer]
        end
    end
end


for i, v in ipairs(sequences) do
    local inputValue = 0
    amps = {}
    for amp = 1, #v do
        local output, t = intCode(inputCode, v[amp])
        inputValue = intCode(t,inputValue)
    end
end