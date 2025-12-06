local aoc = require "lib.aoc"

local raw = aoc.input.getInput()

local lines = {}
for line in raw:gmatch("[^\n]+") do
    table.insert(lines, line)
end

local H = #lines
local W = 0
for _, line in ipairs(lines) do
    if #line > W then
        W = #line
    end
end

for i, line in ipairs(lines) do
    if #line < W then
        lines[i] = line .. string.rep(" ", W - #line)
    end
end

local grid = {}
for y = 1, H do
    grid[y] = {}
    for x = 1, W do
        grid[y][x] = lines[y]:sub(x, x)
    end
end

local function is_empty_column(x)
    for y = 1, H do
        if grid[y][x] ~= " " then
            return false
        end
    end
    return true
end

local groups = {}
do
    local x = 1
    while x <= W do
        if is_empty_column(x) then
            x = x + 1
        else
            local L = x
            while x <= W and not is_empty_column(x) do
                x = x + 1
            end
            local R = x - 1
            table.insert(groups, {
                L = L,
                R = R
            })
        end
    end
end

local function answer1()
    local total = 0

    for _, g in ipairs(groups) do
        local L, R = g.L, g.R

        local op = nil
        for x = L, R do
            local c = grid[H][x]
            if c == "+" or c == "*" then
                op = c
                break
            end
        end

        if op then
            local nums = {}

            -- Cada fila (1..H-1) puede tener un número dentro del bloque [L,R]
            for y = 1, H - 1 do
                local substr = ""
                for x = L, R do
                    substr = substr .. grid[y][x]
                end
                local digits = substr:gsub("%s", "")
                if digits ~= "" then
                    local n = tonumber(digits)
                    if n then
                        table.insert(nums, n)
                    end
                end
            end

            if #nums > 0 then
                local acc
                if op == "+" then
                    acc = 0
                    for _, v in ipairs(nums) do
                        acc = acc + v
                    end
                else -- "*"
                    acc = 1
                    for _, v in ipairs(nums) do
                        acc = acc * v
                    end
                end
                total = total + acc
            end
        end
    end

    return total
end

local function answer2()
    local total = 0

    for _, g in ipairs(groups) do
        local L, R = g.L, g.R

        -- Operador en la fila inferior (igual que antes)
        local op = nil
        for x = L, R do
            local c = grid[H][x]
            if c == "+" or c == "*" then
                op = c
                break
            end
        end

        if op then
            local nums = {}

            -- De derecha a izquierda, cada columna es un número (vertical)
            for x = R, L, -1 do
                local digits = ""
                for y = 1, H - 1 do
                    local c = grid[y][x]
                    if c:match("%d") then
                        digits = digits .. c
                    end
                end
                if digits ~= "" then
                    local n = tonumber(digits)
                    if n then
                        table.insert(nums, n)
                    end
                end
            end

            if #nums > 0 then
                local acc
                if op == "+" then
                    acc = 0
                    for _, v in ipairs(nums) do
                        acc = acc + v
                    end
                else -- "*"
                    acc = 1
                    for _, v in ipairs(nums) do
                        acc = acc * v
                    end
                end
                total = total + acc
            end
        end
    end

    return total
end

local part1 = answer1()
local part2 = answer2()

print("The answer 1 is: " .. answer1())
print("The answer 2 is: " .. answer2())
