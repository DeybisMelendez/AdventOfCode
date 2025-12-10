local aoc = require "lib.aoc"
local bit = require("bit")

local function patternToBitmask(pattern)
    local mask = 0
    for i = 1, #pattern do
        if pattern:sub(i, i) == "#" then
            mask = bit.bor(mask, bit.lshift(1, i - 1))
        end
    end
    return mask
end

local function buttonToBitmask(indices)
    local mask = 0
    for _, idx in ipairs(indices) do
        mask = bit.bor(mask, bit.lshift(1, idx))
    end
    return mask
end

local function getInput()
    local input = aoc.input.getInput()
    input = aoc.string.split(input, "\n")

    for i = 1, #input do
        local line = input[i]
        line = line:gsub("[%[%]()%{%}]", "")
        line = aoc.string.split(line, "%s")

        local buttons = {}
        for j = 2, #line - 1 do
            local bitmask = buttonToBitmask(aoc.string.split(line[j], ","))
            table.insert(buttons, bitmask)
        end
        local joltages = {}
        for i, v in ipairs(aoc.string.split(line[#line], ",")) do
            joltages[i] = tonumber(v)
        end

        input[i] = {
            pattern = patternToBitmask(line[1]),
            buttons = buttons,
            joltages = joltages
        }
    end

    return input
end

local function pushHeap(heap, node)
    table.insert(heap, node)
    local i = #heap
    while i > 1 do
        local p = math.floor(i / 2)
        if heap[p].prio <= heap[i].prio then
            break
        end
        heap[p], heap[i] = heap[i], heap[p]
        i = p
    end
end

local function popHeap(heap)
    local root = heap[1]
    heap[1] = heap[#heap]
    table.remove(heap)
    local i = 1
    while true do
        local l = i * 2
        local r = l + 1
        local smallest = i

        if l <= #heap and heap[l].prio < heap[smallest].prio then
            smallest = l
        end
        if r <= #heap and heap[r].prio < heap[smallest].prio then
            smallest = r
        end
        if smallest == i then
            break
        end

        heap[i], heap[smallest] = heap[smallest], heap[i]
        i = smallest
    end
    return root
end

-- PARTE 1: BFS
local function solveMachine(pattern, buttons)
    local target = pattern

    local queue = {}
    local head, tail = 1, 1
    local visited = {}

    queue[tail] = {
        state = 0,
        dist = 0
    }
    tail = tail + 1
    visited[0] = true

    while head < tail do
        local node = queue[head]
        head = head + 1

        local state = node.state
        local dist = node.dist

        if state == target then
            return dist
        end

        for _, bmask in ipairs(buttons) do
            local next_state = bit.bxor(state, bmask)
            if not visited[next_state] then
                visited[next_state] = true
                queue[tail] = {
                    state = next_state,
                    dist = dist + 1
                }
                tail = tail + 1
            end
        end
    end

    return nil
end

-- PARTE 2: A*
local function solveMachineJoltage(target, buttons)

    local n = #target
    local inc = {}
    for bi, mask in ipairs(buttons) do
        local arr = {}
        for idx = 0, 31 do
            if bit.band(mask, bit.lshift(1, idx)) ~= 0 then
                table.insert(arr, idx + 1) -- counters son 1-based
            end
        end
        inc[bi] = arr
    end

    local function heuristic(state)
        local best = 0
        for i = 1, n do
            local need = target[i] - state[i]
            if need > best then
                best = need
            end
        end
        return best
    end

    local function encode(state)
        return table.concat(state, ",")
    end

    local start = {}
    for i = 1, n do
        start[i] = 0
    end
    local key0 = encode(start)

    local heap = {}
    pushHeap(heap, {
        state = start,
        g = 0,
        prio = heuristic(start)
    })

    local visited = {}
    visited[key0] = 0

    while #heap > 0 do
        local node = popHeap(heap)
        local state = node.state
        local g = node.g

        local done = true
        for i = 1, n do
            if state[i] ~= target[i] then
                done = false
                break
            end
        end
        if done then
            return g
        end

        for b = 1, #inc do
            local next_state = {}
            local ok = true

            -- copiar y sumar incrementos
            for i = 1, n do
                next_state[i] = state[i]
            end
            for _, idx in ipairs(inc[b]) do
                next_state[idx] = next_state[idx] + 1
                -- poda: si supera target, no sirve
                if next_state[idx] > target[idx] then
                    ok = false
                    break
                end
            end

            if ok then
                local key = encode(next_state)
                local ng = g + 1

                if not visited[key] or ng < visited[key] then
                    visited[key] = ng
                    local h = heuristic(next_state)
                    pushHeap(heap, {
                        state = next_state,
                        g = ng,
                        prio = ng + h
                    })
                end
            end
        end
    end

    return nil -- no debería ocurrir si los datos son válidos
end

local function answer1()
    local total = 0
    local machines = getInput()

    for _, machine in ipairs(machines) do
        total = total + solveMachine(machine.pattern, machine.buttons)
    end

    return total
end

local function answer2()
    local total = 0
    local machines = getInput()

    for _, machine in ipairs(machines) do
        total = total + solveMachineJoltage(machine.joltages, machine.buttons)
    end

    return total
end

print("answer 1 is " .. answer1())
print("answer 2 is " .. answer2())
