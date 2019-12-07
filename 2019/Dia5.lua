local inputCode = {

1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,9,23,1,23,6,27,1,9,27,31,1,31,10,35,2,13,35,39,1,39,10,43,1,43,9,47,1,47,13,51,1,51,13,55,2,55,6,59,1,59,5,63,2,10,63,67,1,67,9,71,1,71,13,75,1,6,75,79,1,10,79,83,2,9,83,87,1,87,5,91,2,91,9,95,1,6,95,99,1,99,5,103,2,103,10,107,1,107,6,111,2,9,111,115,2,9,115,119,2,13,119,123,1,123,9,127,1,5,127,131,1,131,2,135,1,135,6,0,99,2,0,14,0

}
local output = 19690720

local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end

local function intCode(i, noun, verb)
    local input = copyTable(i)
    input[1+1] = noun
    input[2+1] = verb
    local pointer = 1 --Tablas en lua comienzan con 1, no 0
    local opCode = 0
    while opCode ~= 99 do
        opCode = input[pointer]
        if opCode == 1 then
            input[input[pointer+3]+1] = input[input[pointer+1]+1] + input[input[pointer+2]+1]
        elseif opCode == 2 then
            input[input[pointer+3]+1] = input[input[pointer+1]+1] * input[input[pointer+2]+1]
        elseif opCode == 3 then
            input[input[pointer+1]+1] = input[pointer+1]
        end
        pointer = pointer + 4
    end
    return input[1]
end

local function nounAndVerbWithOutput(i, o)
    for n=0, 99 do
        for v=0, 99 do
            local input = copyTable(i)
            if intCode(input, n, v) == o then
                return n*100 + v
            end
        end
    end
end

print("answer 1: " .. intCode(inputCode, 12, 2))
print("answer 2: " .. nounAndVerbWithOutput(inputCode, output))