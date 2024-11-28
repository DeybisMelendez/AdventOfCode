local aoc = require "lib.aoc"

local input = aoc.input.getInput()

input = input:gsub("can fly ", "")
input = input:gsub("km/s for ", "")
input = input:gsub("seconds, but then must rest for ", "")
input = input:gsub(" seconds.", "")
input = aoc.string.split(input, "\n")

local function compete(time)
    local bestRaindeers = {}
    for _, line in ipairs(input) do
        line = aoc.string.split(line, "%s")
        local raindeer = line[1]
        local speed = tonumber(line[2])
        local seconds = tonumber(line[3])
        local mustRest = tonumber(line[4])
        local totalSeconds = seconds + mustRest
        local distance = math.floor(time / totalSeconds) * speed * seconds
        local remain = tonumber(time % totalSeconds)

        if remain >= seconds then
            remain = seconds
        end
        distance = distance + remain * speed

        if bestRaindeers[1] == nil then
            bestRaindeers[1] = {
                name = raindeer,
                distance = distance
            }
        elseif distance > bestRaindeers[1].distance then
            bestRaindeers = {
                {
                    name = raindeer,
                    distance = distance
                }
            }
        elseif distance == bestRaindeers[1].distance then
            table.insert(bestRaindeers, {
                name = raindeer,
                distance = distance
            })
        end
    end

    return bestRaindeers
end

local function answer1()
    return compete(2503)[1].distance
end

local function answer2()
    local score = {}
    local bestScore = 0
    for i = 1, 2503 do
        local bestRaindeers = compete(i)
        for _, bestRaindeer in ipairs(bestRaindeers) do
            if score[bestRaindeer.name] == nil then
                score[bestRaindeer.name] = 1
            else
                score[bestRaindeer.name] = score[bestRaindeer.name] + 1
            end
        end
    end

    for _, points in pairs(score) do
        if points > bestScore then
            bestScore = points
        end
    end

    return bestScore
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
