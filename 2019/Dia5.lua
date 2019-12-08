local inputCode = {

3,225,1,225,6,6,1100,1,238,225,104,0,1102,89,49,225,1102,35,88,224,101,-3080,224,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,1101,25,33,224,1001,224,-58,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1102,78,23,225,1,165,169,224,101,-80,224,224,4,224,102,8,223,223,101,7,224,224,1,224,223,223,101,55,173,224,1001,224,-65,224,4,224,1002,223,8,223,1001,224,1,224,1,223,224,223,2,161,14,224,101,-3528,224,224,4,224,1002,223,8,223,1001,224,7,224,1,224,223,223,1002,61,54,224,1001,224,-4212,224,4,224,102,8,223,223,1001,224,1,224,1,223,224,223,1101,14,71,225,1101,85,17,225,1102,72,50,225,1102,9,69,225,1102,71,53,225,1101,10,27,225,1001,158,34,224,101,-51,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,102,9,154,224,101,-639,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,108,226,226,224,102,2,223,223,1006,224,329,101,1,223,223,1007,677,677,224,1002,223,2,223,1005,224,344,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,359,1001,223,1,223,108,226,677,224,1002,223,2,223,1005,224,374,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,389,101,1,223,223,1107,226,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,419,101,1,223,223,1007,226,226,224,102,2,223,223,1006,224,434,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,7,226,677,224,102,2,223,223,1006,224,479,101,1,223,223,1008,226,677,224,1002,223,2,223,1006,224,494,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,509,1001,223,1,223,1108,226,226,224,1002,223,2,223,1006,224,524,101,1,223,223,7,226,226,224,102,2,223,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,107,677,677,224,102,2,223,223,1006,224,569,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,584,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,599,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,614,101,1,223,223,108,677,677,224,102,2,223,223,1005,224,629,1001,223,1,223,8,677,677,224,1002,223,2,223,1005,224,644,1001,223,1,223,7,677,226,224,102,2,223,223,1006,224,659,1001,223,1,223,1007,226,677,224,102,2,223,223,1005,224,674,101,1,223,223,4,223,99,226

}
--local output = 1

local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end
-- separar en modos
local function intCode(i)--, noun, verb)
    local input = copyTable(i)
    -- input[1+1] = noun
    -- input[2+1] = verb
    local pointer = 1 --Tablas en lua comienzan con 1, no 0
    local opCode = 0
    local inputValue = 0
    while opCode ~= 99 do
        local code = tostring(input[pointer])
        opCode = tonumber(code:sub(code:len()-1, code:len()))
        local addPointer = 4
        if opCode > 2 then addPointer = 2 end
        for char=0, parameters:len() do
            print("code: " .. code .. ", opcode: " .. opCode .. ", parameterMode: " .. parameterMode)
            if parameterMode == 0 then -- parametro de posicion
                if opCode == 1 then
                    input[input[pointer+3]+1] = input[input[pointer+1]+1] + input[input[pointer+2]+1]
                elseif opCode == 2 then
                    input[input[pointer+3]+1] = input[input[pointer+1]+1] * input[input[pointer+2]+1]
                -- nuevas instrucciones
                elseif opCode == 3 then
                    input[input[pointer+1]+1] = inputValue
                elseif opCode == 4 then
                    inputValue = input[input[pointer+1]+1]
                end
            elseif parameterMode == 1 then
                if opCode == 1 then
                    input[input[pointer+3]+1] = input[pointer+1]+1 + input[pointer+2]+1
                elseif opCode == 2 then
                    input[input[pointer+3]+1] = input[pointer+1]+1 * input[pointer+2]+1
                -- nuevas instrucciones
                elseif opCode == 3 then
                    input[input[pointer+1]+1] = inputValue
                elseif opCode == 4 then
                    inputValue = input[pointer+1]+1
                end
            end
        end
        pointer = pointer + addPointer
        print("InputValue: " .. inputValue)
    end
    return input[1]
end

-- local function nounAndVerbWithOutput(i, o)
--     for n=0, 99 do
--         for v=0, 99 do
--             local input = copyTable(i)
--             if intCode(input, n, v) == o then
--                 return n*100 + v
--             end
--         end
--     end
-- end
print("answer 1: " .. intCode(inputCode))
-- print("answer 1: " .. intCode(inputCode, 12, 2))
--print("answer 2: " .. nounAndVerbWithOutput(inputCode, output))