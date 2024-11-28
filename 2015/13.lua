local aoc = require "lib.aoc"

local function getInput(extra)
    local str = aoc.input.getInput()
    str = str:gsub(" would", "")
    str = str:gsub("happiness units by sitting next to ", "")
    str = str:gsub("%.", "")
    extra = extra or ""
    str = str .. extra
    local attendees = {}
    local input = {}
    local lines = aoc.string.split(str, "\n")
    for _, line in ipairs(lines) do
        line = aoc.string.split(line, "%s")
        local attendee = line[1]
        table.remove(line, 1)

        if type(input[attendee]) == "table" then
            table.insert(input[attendee], line)
        else
            input[attendee] = { line }
        end

        if not aoc.list.contains(attendees, attendee) then
            table.insert(attendees, attendee)
        end
    end
    return input, aoc.list.permute(attendees)
end

local function totalHappiness(input, attendeesPerm)
    local total = 0
    for _, attendees in ipairs(attendeesPerm) do
        local newTotal = 0
        for position, attendee in ipairs(attendees) do
            local next, before = position + 1, position - 1

            if next > #attendees then next = 1 end
            if before < 1 then before = #attendees end

            local nextAttendee = attendees[next]
            local beforeAttendee = attendees[before]

            for _, line in ipairs(input[attendee]) do
                local neighbor = line[3]
                if neighbor == nextAttendee or neighbor == beforeAttendee then
                    local happiness = line[2]
                    local op = line[1] -- gain or lose
                    if op == "gain" then
                        newTotal = newTotal + happiness
                    elseif op == "lose" then
                        newTotal = newTotal - happiness
                    end
                end
            end
        end
        if newTotal > total then
            total = newTotal
        end
    end
    return total
end

local function answer1()
    local input, combs = getInput()
    return totalHappiness(input, combs)
end

local function answer2()
    local me = [[
Damattendees would gain 0 happiness units by sitting next to Bob.
Damattendees would gain 0 happiness units by sitting next to Carol.
Damattendees would lose 0 happiness units by sitting next to Daattendeesid.
Damattendees would lose 0 happiness units by sitting next to Eric.
Damattendees would gain 0 happiness units by sitting next to Frank.
Damattendees would gain 0 happiness units by sitting next to George.
Damattendees would gain 0 happiness units by sitting next to Mallory.
Alice would gain 0 happiness units by sitting next to Damattendees.
Bob would gain 0 happiness units by sitting next to Damattendees.
Carol would gain 0 happiness units by sitting next to Damattendees.
Daattendeesid would gain 0 happiness units by sitting next to Damattendees.
Eric would gain 0 happiness units by sitting next to Damattendees.
Frank would gain 0 happiness units by sitting next to Damattendees.
George would gain 0 happiness units by sitting next to Damattendees.
Mallory would gain 0 happiness units by sitting next to Damattendees.]]
    local input, combs = getInput(me)
    return totalHappiness(input, combs)
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
