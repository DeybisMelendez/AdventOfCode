local aoc = require "lib.aoc"
local tickerTape = {
    children = 3,
    cats = 7,
    samoyeds = 2,
    pomeranians = 3,
    akitas = 0,
    vizslas = 0,
    goldfish = 5,
    trees = 3,
    cars = 2,
    perfumes = 1
}
local input = aoc.input.getInput()
input = string.gsub(input, ":", "")
input = string.gsub(input, ",", "")
input = string.gsub(input, "Sue ", "")
input = aoc.string.split(input, "\n")

local function isAuntSue(compounds)
    for compound, value in pairs(compounds) do
        if tickerTape[compound] ~= value and value ~= 0 then
            return false
        end
    end
    return true
end

local function isAuntSue2(compounds)
    for compound, value in pairs(compounds) do
        if (compound == "cats" or compound == "trees") and (value <= tickerTape[compound]) then
            return false
        elseif (compound == "pomeranians" or compound == "goldfish") and value >= tickerTape[compound] then
            return false
        elseif compound ~= "cats" and compound ~= "trees" and compound ~= "pomeranians" and compound ~= "goldfish" then
            if tickerTape[compound] ~= value then
                return false
            end
        end
    end
    return true
end


local function answer1()
    for _, line in ipairs(input) do
        local compounds = {}
        line = aoc.string.split(line, "%s")
        compounds[line[2]] = tonumber(line[3])
        compounds[line[4]] = tonumber(line[5])
        compounds[line[6]] = tonumber(line[7])
        if isAuntSue(compounds) then
            return line[1]
        end
    end
    return "not found"
end

local function answer2()
    for _, line in ipairs(input) do
        local compounds = {}
        line = aoc.string.split(line, "%s")
        compounds[line[2]] = tonumber(line[3])
        compounds[line[4]] = tonumber(line[5])
        compounds[line[6]] = tonumber(line[7])
        if isAuntSue2(compounds) then
            return line[1]
        end
    end
    return "not found"
end

print("answer 1 is " .. answer1())
print("answer 1 is " .. answer2())
