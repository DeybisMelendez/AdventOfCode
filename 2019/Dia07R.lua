local inputCode = {
3,8,1001,8,10,8,105,1,0,0,21,38,63,72,81,106,187,268,349,430,99999,3,9,101,5,9,9,1002,9,3,9,101,3,9,9,4,9,99,3,9,102,3,9,9,101,4,9,9,1002,9,2,9,1001,9,2,9,1002,9,4,9,4,9,99,3,9,1001,9,3,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,4,9,9,1001,9,2,9,1002,9,5,9,1001,9,2,9,102,3,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99
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

local IntCode = require "IntCode"

local function getResult1(n, m)
    local sequences = getSequences(n, m)
    local result = 0
    for _, v in ipairs(sequences) do
        local inputValue = 0
        for i=1, #v do
            local amp = deepcopy(IntCode)
			amp:setMemory(deepcopy(inputCode))
			amp:addInputValue(v[i], inputValue)
			--amp:run()
            inputValue = amp:run(nil, true)--amp:getOutput()
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
            table.insert(amps, deepcopy(IntCode))
			amps[i]:setMemory(deepcopy(inputCode))
			--amps[i]:addInputValue(v[i], inputValue)
			--amps[i]:run()
			--inputValue = amps[i]:getOutput()
        end
        local done = false
        local output
        while not done do
            for i=1, #v do
                if inputValue == nil then break end
                output = inputValue
				amps[i].inputs[1] = v[i]
				amps[i].inputs[2] = inputValue
				inputValue = amps[i]:run(nil, true)
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