local UF = {}
UF.__index = UF

function UF.new()
    return setmetatable({
        parent = {},
        size = {}
    }, UF)
end

function UF:make(x)
    self.parent[x] = x
    self.size[x] = 1
end

function UF:find(x)
    if self.parent[x] ~= x then
        self.parent[x] = self:find(self.parent[x])
    end
    return self.parent[x]
end

function UF:union(a, b)
    local ra = self:find(a)
    local rb = self:find(b)
    if ra == rb then
        return false
    end

    -- union by size
    if self.size[ra] < self.size[rb] then
        ra, rb = rb, ra
    end

    self.parent[rb] = ra
    self.size[ra] = self.size[ra] + self.size[rb]
    return true
end
return UF
