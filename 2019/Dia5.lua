local inputCode = {
3,225,1,225,6,6,1100,1,238,225,104,0,1102,89,49,225,1102,35,88,224,101,-3080,224,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,1101,25,33,224,1001,224,-58,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1102,78,23,225,1,165,169,224,101,-80,224,224,4,224,102,8,223,223,101,7,224,224,1,224,223,223,101,55,173,224,1001,224,-65,224,4,224,1002,223,8,223,1001,224,1,224,1,223,224,223,2,161,14,224,101,-3528,224,224,4,224,1002,223,8,223,1001,224,7,224,1,224,223,223,1002,61,54,224,1001,224,-4212,224,4,224,102,8,223,223,1001,224,1,224,1,223,224,223,1101,14,71,225,1101,85,17,225,1102,72,50,225,1102,9,69,225,1102,71,53,225,1101,10,27,225,1001,158,34,224,101,-51,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,102,9,154,224,101,-639,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,108,226,226,224,102,2,223,223,1006,224,329,101,1,223,223,1007,677,677,224,1002,223,2,223,1005,224,344,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,359,1001,223,1,223,108,226,677,224,1002,223,2,223,1005,224,374,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,389,101,1,223,223,1107,226,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,419,101,1,223,223,1007,226,226,224,102,2,223,223,1006,224,434,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,7,226,677,224,102,2,223,223,1006,224,479,101,1,223,223,1008,226,677,224,1002,223,2,223,1006,224,494,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,509,1001,223,1,223,1108,226,226,224,1002,223,2,223,1006,224,524,101,1,223,223,7,226,226,224,102,2,223,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,107,677,677,224,102,2,223,223,1006,224,569,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,584,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,599,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,614,101,1,223,223,108,677,677,224,102,2,223,223,1005,224,629,1001,223,1,223,8,677,677,224,1002,223,2,223,1005,224,644,1001,223,1,223,7,677,226,224,102,2,223,223,1006,224,659,1001,223,1,223,1007,226,677,224,102,2,223,223,1005,224,674,101,1,223,223,4,223,99,226
--3,9,8,9,10,9,4,9,99,-1,8
--3,9,7,9,10,9,4,9,99,-1,8
--3,3,1108,-1,8,3,4,3,99
--3,3,1107,-1,8,3,4,3,99
--3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9
}
local output = 0

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
        for _=1, 5-(code:len()) do
            code = "0" .. code
        end
        opCode = tonumber(code:sub(code:len()-1, code:len()))
        if opCode == 99 then return output end
        local param1, param2, param3
        if tonumber(code:sub(3,3)) == 0 then param1 = input[pointer+1]+1 else param1 = pointer+1 end
        if opCode ~= 4 and opCode ~= 3 then
            if tonumber(code:sub(2,2)) == 0 then param2 = input[pointer+2]+1 else param2 = pointer+2 end
        end
        if opCode ~= 4 and opCode ~= 3 and opCode ~= 5 and opCode ~= 6 then
            if tonumber(code:sub(1,1)) == 0 then param3 = input[pointer+3]+1 else param3 = pointer+3 end
        end
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
            output = input[param1]
            pointer = pointer + 2
        -- Nuevas instrucciones PARTE 2
        elseif opCode == 5 then
            if input[param1] ~= 0 then pointer = input[param2] else pointer = pointer + 3 end
            print(pointer)
        elseif opCode == 6 then
            if input[param1] == 0 then pointer = input[param2] else pointer = pointer + 3 end
        elseif opCode == 7 then
            if input[param1] < input[param2] then input[input[pointer+3]+1] = 1 else input[input[pointer+3]+1] = 0 end
            pointer = pointer + 4
        elseif opCode == 8 then
            if input[param1] == input[param2] then input[input[pointer+3]+1] = 1 else input[input[pointer+3]+1] = 0 end
            pointer = pointer + 4
        else
            return "error, pointer: " .. pointer
        end
    end
end
print("the answer 1 is: " .. intCode(inputCode, 1))
print("the answer 2 is: " .. intCode(inputCode, 5))
--print("the answer 1 is: " .. intCode(inputCode, 9))