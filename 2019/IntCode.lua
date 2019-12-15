local IntCode = {memory = {}, pointer = 1}
function IntCode:new(input)
	local t = {}
	self.__index = self
	setmetatable(t, self)
	t.memory = input
	return t
end

function IntCode:add(param1, param2, param3) -- OpCode 1
	self.memory[param3] = self.memory[param1] + self.memory[param2]
	self.pointer = self.pointer + 4
end

function IntCode:multiply(param1, param2, param3) -- OpCode 2
	self.memory[param3] = self.memory[param1] * self.memory[param2]
	self.pointer = self.pointer + 4
end

function IntCode:input()
end

function IntCode:outputs()
end

function IntCode:PositionParam(p) -- integer
	--p = p or error("Parametro no existe en la memoria")
	return self.memory[self.pointer + p] + 1
end

function IntCode:run()
	local opCode = 0
	local done = false
	while not done do
		opCode = self.memory[self.pointer]
		if opCode == 1 then self:add(self:PositionParam(1), self:PositionParam(2), self:PositionParam(3))
		elseif opCode == 2 then self:multiply(self:PositionParam(1), self:PositionParam(2), self:PositionParam(3))
		elseif opCode == 99 then done = true
		else error("no existe opCode")
		end
	end
end
return IntCode