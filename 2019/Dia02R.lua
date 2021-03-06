local inputCode = {

1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,9,23,1,23,6,27,1,9,27,31,1,31,10,35,2,13,35,39,1,39,10,43,1,43,9,47,1,47,13,51,1,51,13,55,2,55,6,59,1,59,5,63,2,10,63,67,1,67,9,71,1,71,13,75,1,6,75,79,1,10,79,83,2,9,83,87,1,87,5,91,2,91,9,95,1,6,95,99,1,99,5,103,2,103,10,107,1,107,6,111,2,9,111,115,2,9,115,119,2,13,119,123,1,123,9,127,1,5,127,131,1,131,2,135,1,135,6,0,99,2,0,14,0

}
local output = 19690720
local IntCode = require "IntCode"
local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function answer1(noun, verb)
	local input1 = deepcopy(inputCode)
	input1[2] = noun
	input1[3] = verb
	local computer = deepcopy(IntCode)
	computer:setMemory(input1)
	computer:run()
	return computer.memory[1]
end
local function nounAndVerbWithOutput(output)
    for n=0, 99 do
        for v=0, 99 do
            if answer1(n, v) == output then
                return n*100 + v
            end
        end
    end
end

print("answer 1: " .. answer1(12, 2))
print("answer 2: " .. nounAndVerbWithOutput(output))