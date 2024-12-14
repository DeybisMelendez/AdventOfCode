local aoc = require "lib.aoc"
local width = 101
local height = 103
local function getInput()
    local input = aoc.input.getInput()
    input = aoc.string.split(input, "\n")
    for i, line in ipairs(input) do
        local x, y, xSpeed, ySpeed = line:match("p=([-%d]+),([-%d]+) v=([-%d]+),([-%d]+)")
        input[i] = { pos = { x = tonumber(x) + 1, y = tonumber(y) + 1 }, speed = { x = tonumber(xSpeed), y = tonumber(ySpeed) } }
    end
    return input
end

local function moveRobot(robot, seconds)
    if seconds == 0 then
        return
    end
    if robot.pos.x + robot.speed.x > width then
        robot.pos.x = robot.pos.x + robot.speed.x - width
    elseif robot.pos.x + robot.speed.x < 1 then
        robot.pos.x = robot.pos.x + robot.speed.x + width
    else
        robot.pos.x = robot.pos.x + robot.speed.x
    end
    if robot.pos.y + robot.speed.y > height then
        robot.pos.y = robot.pos.y + robot.speed.y - height
    elseif robot.pos.y + robot.speed.y < 1 then
        robot.pos.y = robot.pos.y + robot.speed.y + height
    else
        robot.pos.y = robot.pos.y + robot.speed.y
    end
    moveRobot(robot, seconds - 1)
end

local function answer1()
    local q1, q2, q3, q4 = 0, 0, 0, 0
    local robots = getInput()
    for _, robot in ipairs(robots) do
        moveRobot(robot, 100)
        if robot.pos.x < 51 and robot.pos.y < 52 then
            q1 = q1 + 1
        elseif robot.pos.x > 51 and robot.pos.y < 52 then
            q2 = q2 + 1
        elseif robot.pos.x < 51 and robot.pos.y > 52 then
            q3 = q3 + 1
        elseif robot.pos.x > 51 and robot.pos.y > 52 then
            q4 = q4 + 1
        end
    end
    return q1 * q2 * q3 * q4
end

local function answer2()
    local robots = getInput()
    local step = 0
    for _, robot in ipairs(robots) do
        moveRobot(robot, step)
    end
    print("Busque manualmente el arbol, presione enter para ir al siguiente:")
    while io.read() ~= "\n" do
        step = step + 1
        print("Step: ", step)


        for _, robot in ipairs(robots) do
            moveRobot(robot, 1)
        end
        for y = 1, height do
            for x = 1, width do
                local isRobot = false
                for _, robot in ipairs(robots) do
                    if robot.pos.x == x and robot.pos.y == y then
                        isRobot = true
                        break
                    end
                end
                if isRobot then
                    io.write("#")
                else
                    io.write(".")
                end
            end
            print()
        end
    end
    return step
end


print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
