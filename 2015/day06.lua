local file = io.open("day06input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end
text = string.gsub(text, "turn on", "turn_on")
text = string.gsub(text, "turn off", "turn_off")
text = string.gsub(text, "through ", "")
text = string.gsub(text, ",", " ")

local instructions = split(text, "[^\n]+")
local grid = {}
for y=0, 999 do
    grid[y] = {}
    for x=0, 999 do
        grid[y][x] = 0
    end
end
local function answer1()
    for i=1, #instructions do
        local ins = instructions[i]
        ins = split(ins, "[^%s]+")
        local y1, x1, y2, x2 = tonumber(ins[2]), tonumber(ins[3]), tonumber(ins[4]), tonumber(ins[5])
        if ins[1] == "turn_on" then
            for y=y1, y2 do
                for x=x1, x2 do
                    grid[y][x] = 1
                end
            end
        elseif ins[1] == "turn_off" then
            for y=y1, y2 do
                for x=x1, x2 do
                    grid[y][x] = 0
                end
            end
        else
            for y=y1, y2 do
                for x=x1, x2 do
                    if grid[y][x] == 0 then
                        grid[y][x] = 1
                    else
                        grid[y][x] = 0
                    end
                end
            end
        end
    end
    local count = 0
    for y=1, #grid do
        for x=1, #grid[y] do
            if grid[y][x] == 1 then
                count = count + 1
            end
        end
    end
    return count
end
print(answer1())
