-- Librería escrita por Deybis Melendez que contiene utilerías
-- para realizar los puzzles de advent of code

local aoc = {
    input = {},
    debug = {},
    string = {},
    list = {},
    dict = {},
    search = {},
}

function aoc.debug.timeExecution(func, ...)
    local start = os.clock()
    local result = func(...)
    local finish = os.clock()
    print("Execution time: " .. (finish - start) .. " seconds with output: ")
    print(result)
end

function aoc.input.getInput(filename)
    filename = filename or "input.txt"
    local file = io.open(filename, "r")
    if file == nil then
        error("File not found: " .. filename)
    end
    local text = file:read("*a")
    file:close()
    return text
end

function aoc.string.split(str, separator)
    local t = {}
    for value in str:gmatch("([^" .. separator .. "]+)") do
        table.insert(t, value)
    end
    return t
end

function aoc.string.replace(str, content, from, to)
    return str:sub(1, from - 1) .. content .. str:sub(to + 1)
end

function aoc.string.iterate(str)
    local index = 1
    local len = #str
    return function()
        if index <= len then
            local char = str:sub(index, index)
            local currentIndex = index -- Guardar el índice actual antes de incrementarlo
            index = index + 1
            return currentIndex, char
        end
        return nil, nil -- Termina la iteración
    end
end

function aoc.list.indexOf(t, val)
    for k, v in pairs(t) do
        if v == val then return k end
    end
end

function aoc.list.contains(tbl, element)
    for _, v in ipairs(tbl) do
        if v == element then
            return true
        end
    end
    return false
end

function aoc.list.unique(tbl)
    local result = {}
    local seen = {}
    for _, v in ipairs(tbl) do
        if not seen[v] then
            seen[v] = true
            table.insert(result, v)
        end
    end
    return result
end

function aoc.list.concat(t1, t2)
    local len = #t1
    for i = 1, #t2 do
        t1[len + i] = t2[i]
    end
end

function aoc.list.map(tbl, func)
    for i, v in ipairs(tbl) do
        tbl[i] = func(v)
    end
end

function aoc.list.filter(tbl, predicate)
    local i = 1
    while i <= #tbl do
        if not predicate(tbl[i]) then
            table.remove(tbl, i)
        else
            i = i + 1
        end
    end
end

function aoc.list.reduce(tbl, func, initial)
    local accumulator = initial or 0
    for _, v in ipairs(tbl) do
        accumulator = func(accumulator, v)
    end
    return accumulator
end

function aoc.list.find(tbl, predicate)
    for i, v in ipairs(tbl) do
        if predicate(v) then
            return v, i
        end
    end
    return nil, nil
end

function aoc.list.permute(t)
    if #t == 0 then
        return { {} }
    end

    local permuted = {}

    for i = 1, #t do
        local current = t[i]
        local remaining = {}

        for j = 1, #t do
            if j ~= i then
                table.insert(remaining, t[j])
            end
        end

        for _, p in ipairs(aoc.list.permute(remaining)) do
            table.insert(permuted, { current, unpack(p) })
        end
    end

    return permuted
end

function aoc.dict.getKeys(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

function aoc.search.bfs(start, goal, neighbors)
    local queue = { start }
    local visited = {}
    local prev = {}

    while #queue > 0 do
        local node = table.remove(queue, 1)
        if node == goal then
            local path = {}
            while prev[node] do
                table.insert(path, 1, node)
                node = prev[node]
            end
            table.insert(path, 1, start)
            return path
        end
        visited[node] = true
        local neighborsList = neighbors(node)
        for _, neighbor in ipairs(neighborsList) do
            if not visited[neighbor] then
                table.insert(queue, neighbor)
                prev[neighbor] = node
            end
        end
    end
    return nil -- No path found
end

function aoc.search.dijkstra(start, goal, neighbors, weight)
    local openList = {}
    local distances = {}
    local processed = {}

    distances[start[1] .. "," .. start[2]] = 0
    local startNode = {
        x = start[1],
        y = start[2],
        g = 0,
        parent = nil
    }
    table.insert(openList, startNode)

    local function compareNodes(a, b)
        return a.g < b.g
    end

    while #openList > 0 do
        table.sort(openList, compareNodes)
        local currentNode = table.remove(openList, 1)
        local currentKey = currentNode.x .. "," .. currentNode.y
        processed[currentKey] = true

        if currentNode.x == goal[1] and currentNode.y == goal[2] then
            local path = {}
            local node = currentNode
            while node do
                table.insert(path, 1, { node.x, node.y })
                node = node.parent
            end
            return path
        end

        local neighborsList = neighbors(currentNode.x, currentNode.y)

        for _, neighbor in ipairs(neighborsList) do
            local nx, ny = neighbor[1], neighbor[2]
            local neighborKey = nx .. "," .. ny

            if processed[neighborKey] then
                goto continue
            end

            local newG = currentNode.g + weight(currentNode.x, currentNode.y, nx, ny)

            if not distances[neighborKey] or newG < distances[neighborKey] then
                distances[neighborKey] = newG
                local neighborNode = {
                    x = nx,
                    y = ny,
                    g = newG,
                    parent = currentNode
                }
                table.insert(openList, neighborNode)
            end

            ::continue::
        end
    end

    return nil -- No se encontró un camino
end

function aoc.search.aStar(start, goal, heuristic, neighbors, weight)
    local openList = {}
    local closedList = {}
    local openSet = {}

    local startNode = {
        x = start[1],
        y = start[2],
        g = 0,
        h = heuristic(start[1], start[2], goal[1], goal[2]),
        f = 0,
        parent = nil
    }
    table.insert(openList, startNode)
    openSet[start[1] .. "," .. start[2]] = startNode

    local function compareNodes(a, b)
        return a.f < b.f
    end

    while #openList > 0 do
        table.sort(openList, compareNodes)
        local currentNode = table.remove(openList, 1)
        openSet[currentNode.x .. "," .. currentNode.y] = nil

        if currentNode.x == goal[1] and currentNode.y == goal[2] then
            local path = {}
            local node = currentNode
            while node do
                table.insert(path, 1, { node.x, node.y })
                node = node.parent
            end
            return path
        end

        table.insert(closedList, currentNode)

        local neighborsList = neighbors(currentNode.x, currentNode.y)

        for _, neighbor in ipairs(neighborsList) do
            local nx, ny = neighbor[1], neighbor[2]

            local inClosed = false
            for _, closedNode in ipairs(closedList) do
                if closedNode.x == nx and closedNode.y == ny then
                    inClosed = true
                    break
                end
            end
            if inClosed then
                goto continue
            end

            local gCost = currentNode.g + weight(currentNode.x, currentNode.y, nx, ny)
            local hCost = heuristic(nx, ny, goal[1], goal[2])
            local fCost = gCost + hCost

            local neighborKey = nx .. "," .. ny
            local inOpen = openSet[neighborKey]

            if not inOpen or inOpen.f > fCost then
                local newNode = {
                    x = nx,
                    y = ny,
                    g = gCost,
                    h = hCost,
                    f = fCost,
                    parent = currentNode
                }
                table.insert(openList, newNode)
                openSet[neighborKey] = newNode
            end
            ::continue::
        end
    end

    return nil -- No se encontró un camino
end

return aoc
