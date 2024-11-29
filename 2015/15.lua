local aoc = require "lib.aoc"
local input = aoc.input.getInput()
input = string.gsub(input, ",", "")
input = aoc.string.split(input, "\n")

local function getProperties(line)
    line = aoc.string.split(line, "%s")
    local capacity = tonumber(line[3])
    local durability = tonumber(line[5])
    local flavor = tonumber(line[7])
    local texture = tonumber(line[9])
    local calories = tonumber(line[11])
    return {
        capacity = capacity,
        durability = durability,
        flavor = flavor,
        texture = texture,
        calories = calories
    }
end

local function getIngredients()
    local ingredients = {}

    for _, line in ipairs(input) do
        table.insert(ingredients, getProperties(line))
    end
    return ingredients
end

local function calculateScore(ingredients, amounts, evalCalories)
    local capacity, durability, flavor, texture, calories = 0, 0, 0, 0, 0

    for i, ingredient in ipairs(ingredients) do
        capacity = capacity + ingredient.capacity * amounts[i]
        durability = durability + ingredient.durability * amounts[i]
        flavor = flavor + ingredient.flavor * amounts[i]
        texture = texture + ingredient.texture * amounts[i]
        calories = calories + ingredient.calories * amounts[i]
    end
    if evalCalories and calories ~= 500 then
        return 0
    end
    capacity = math.max(0, capacity)
    durability = math.max(0, durability)
    flavor = math.max(0, flavor)
    texture = math.max(0, texture)

    return capacity * durability * flavor * texture
end

local function findBestScore(ingredients, amounts, index, left, evalCalories)
    if index > #ingredients then
        if left == 0 then
            return calculateScore(ingredients, amounts, evalCalories)
        else
            return 0
        end
    end

    local best = 0
    for i = index, left do
        amounts[index] = i
        best = math.max(best, findBestScore(ingredients, amounts, index + 1, left - i, evalCalories))
    end
    amounts[index] = nil
    return best
end

local function answer1()
    local ingredients = getIngredients()
    return findBestScore(ingredients, {}, 1, 100, false)
end

local function answer2()
    local ingredients = getIngredients()
    return findBestScore(ingredients, {}, 1, 100, true)
end

print("answer 1 is " .. answer1())
print("answer 1 is " .. answer2())
