local IntCode = {memory = {}, pointer = 1, output = nil}
function IntCode:new(memory)
	local t = {}
	self.__index = self
	setmetatable(t, self)
	t.memory = memory
	return t
end

function IntCode:add(mode1, mode2, mode3) -- OpCode 1
	if mode3 == 1 then mode3 = 0 end
	self.memory[self:getParam(mode3, 3)] = self.memory[self:getParam(mode1, 1)] + self.memory[self:getParam(mode2, 2)]
	self.pointer = self.pointer + 4
end

function IntCode:multiply(mode1, mode2, mode3) -- OpCode 2
	if mode3 == 1 then mode3 = 0 end
	self.memory[self:getParam(mode3, 3)] = self.memory[self:getParam(mode1, 1)] * self.memory[self:getParam(mode2, 2)]
	self.pointer = self.pointer + 4
end

function IntCode:input(mode1, inputValue) -- OpCode 3
	if mode1 == 1 then mode1 = 0 end
	self.memory[self:getParam(mode1, 1)] = inputValue
	self.pointer = self.pointer + 2
end

function IntCode:outputs(mode1) -- OpCode 4
	--if mode1 == 1 then mode1 = 0 end
	self.output = self.memory[self:getParam(mode1, 1)]
	self.pointer = self.pointer + 2
end

function IntCode:jumpIfTrue(mode1, mode2) -- OpCode 5
	if not(self.memory[self:getParam(mode1, 1)] == 0) then
		self.pointer = self.memory[self:getParam(mode2, 2)] + 1
	else
		self.pointer = self.pointer + 3
	end
end

function IntCode:jumpIfFalse(mode1, mode2) --OpCode 6
	if self.memory[self:getParam(mode1, 1)] == 0 then
		self.pointer = self.memory[self:getParam(mode2, 2)] + 1
	else
		self.pointer = self.pointer + 3
	end
end

function IntCode:lessThan(mode1, mode2, mode3) --OpCode 7
	if mode3 == 1 then mode3 = 0 end
	if self.memory[self:getParam(mode1, 1)] < self.memory[self:getParam(mode2, 2)] then
		self.memory[self:getParam(mode3, 3)] = 1
	else
		self.memory[self:getParam(mode3, 3)] = 0
	end
	self.pointer = self.pointer + 4
end

function IntCode:equals(mode1, mode2, mode3) --OpCode 8
	if mode3 == 1 then mode3 = 0 end
	if self.memory[self:getParam(mode1, 1)] == self.memory[self:getParam(mode2, 2)] then
		self.memory[self:getParam(mode3, 3)] = 1
	else
		self.memory[self:getParam(mode3, 3)] = 0
	end
	self.pointer = self.pointer + 4
end

function IntCode:getParam(mode, parameter)
	if mode == 0 then
		return self:positionParam(parameter)
	elseif mode == 1 then
		return self:inmediateParam(parameter)
	else
		error("modo de parametro desconocido")
	end
end

function IntCode:inmediateParam(p)
	return self.pointer + p
end

function IntCode:positionParam(p) -- integer
	--p = p or error("Parametro no existe en la memoria")
	return self.memory[self.pointer + p] + 1
end

function IntCode:decodePointerMemory()
	local code = tostring(self.memory[self.pointer])
	for _=1, 5-(code:len()) do
		code = "0" .. code
	end
	local opCode = tonumber(code:sub(code:len()-1, code:len()))
	local mode1 = tonumber(code:sub(3,3))
	local mode2 = tonumber(code:sub(2,2))
	local mode3 = tonumber(code:sub(1,1))
	return tonumber(opCode), tonumber(mode1), tonumber(mode2), tonumber(mode3)
end

function IntCode:run(inputValue)
	local done = false
	while not done do
		local opCode, mode1, mode2, mode3 = self:decodePointerMemory()
		if opCode == 1 then self:add(mode1, mode2, mode3)
		elseif opCode == 2 then self:multiply(mode1, mode2, mode3)
		elseif opCode == 3 then self:input(mode1, inputValue)
		elseif opCode == 4 then self:outputs(mode1)
		elseif opCode == 5 then self:jumpIfTrue(mode1, mode2)
		elseif opCode == 6 then self:jumpIfFalse(mode1, mode2)
		elseif opCode == 7 then self:lessThan(mode1, mode2, mode3)
		elseif opCode == 8 then self:equals(mode1, mode2, mode3)
		elseif opCode == 99 then done = false break
		else print(opCode) error("no existe opCode")
		end
	end
	return self.output
end
return IntCode