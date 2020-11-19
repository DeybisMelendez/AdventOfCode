local input = "1321131112"

local function answer1()
    for _=1, 40 do
        local actualChar = ""
        local countChar = 0
        local newInput = ""
        for i=1, #input do
            local a = string.sub(input, i, i)
            if actualChar == a then
                countChar = countChar + 1
            elseif countChar == 0 then
                actualChar = a
                countChar = 1
            else
                newInput = countChar .. actualChar .. newInput
            end
        end
        print(#newInput)
        input = newInput
    end
    return input
end

print(answer1())