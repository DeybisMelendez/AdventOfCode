local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = aoc.string.split(input, "\n")

for i = 1, #input do
    local line = input[i]
    line = line:gsub("%(", "")
    line = line:gsub("%)", "")
    line = line:gsub("%[", "")
    line = line:gsub("%]", "")
    line = line:gsub("{", "")
    line = line:gsub("}", "")
    line = aoc.string.split(line, "%s")
    local toggles = {}
    for j = 2, #line - 1 do
        table.insert(toggles, aoc.string.split(line[j], ","))
    end
    input[i] = {
        lights = aoc.string.splitToChar(line[1]),
        toggles = toggles,
        joltage = aoc.string.split(line[#line], ",")
    }
end

local function searchToggle(machine, lightIndex)
    for i = 1, #machine.toggles do
        local toggle = machine.toggles[i]
        for j = 1, #toggle do
            local index = tonumber(toggle[j])
            if lightIndex == index then
                return i
            end
        end
    end
end

local function applyToggle(lights, toggle)
    for j = 1, #toggle do
        if lights[toggle[j] + 1] == "#" then
            lights[toggle[j] + 1] = "."
        else
            lights[toggle[j] + 1] = "#"
        end
    end
end

local function printLights(lights)
    for i = 1, #lights do
        io.write(lights[i])
    end
    print("")
end

local function isOff(machine)
    for i = 1, #machine.lights do
        if machine.lights[i] == "#" then
            return false
        end
    end
    return true
end

local function nextToggle(machine, memo)
    local min = 1000000
    for i = 1, #machine.lights do
        local light = machine.lights[i]
        if light == '#' then
            local toggle = machine.toggles[searchToggle(machine, i)]
            applyToggle(machine.lights, toggle)
            if isOff(machine) then
                applyToggle(machine.lights, toggle)
                return 1
            end
            local str = table.concat(machine.lights)
            if memo[str] == nil then
                memo[str] = true
            else
                applyToggle(machine.lights, toggle)
                return 1000000
            end

            local newMin = nextToggle(machine, memo) + 1
            if newMin < min then
                min = newMin
            end
            applyToggle(machine.lights, toggle)
        end
    end
    return min
end

local function answer1()
    local total = 0
    for i = 1, #input do
        local machine = input[i]
        local memo = {}
        local minCount = nextToggle(machine, memo)
        -- print(minCount)
        total = total + minCount
    end
    return total
end

print("answer 1 is " .. answer1())
