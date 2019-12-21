local IntCode = {memory = {}, pointer = 1, output = {}, inputs = {}, nextInput=1, baseRelative = 0, stopped = false}
function IntCode:setMemory(memory)
	self.memory = memory
end

function IntCode:addInputValue(...)
	local t = {...}
	for _, v in ipairs(t) do
		table.insert(self.inputs, v)
	end
end
function IntCode:getOutput()
	--print(self.output[#self.output])
	return self.output[#self.output] or nil
end
function IntCode:getInputValue()
	self.nextInput = self.nextInput + 1
	return self.inputs[self.nextInput-1] or self.inputs[#self.inputs] --desactivar or si es necesario
end

function IntCode:add(mode1, mode2, mode3) -- OpCode 1
	if mode3 == 1 then mode3 = 0 end
	--print("add", self:getParam(mode1, 1), self:getParam(mode2, 2))
	self.memory[self:getParam(mode3, 3)] = self.memory[self:getParam(mode1, 1)] + self.memory[self:getParam(mode2, 2)]
	self.pointer = self.pointer + 4
end

function IntCode:multiply(mode1, mode2, mode3) -- OpCode 2
	if mode3 == 1 then mode3 = 0 end
	--print("multiply", self:getParam(mode1, 1), self:getParam(mode2, 2))
	self.memory[self:getParam(mode3, 3)] = self.memory[self:getParam(mode1, 1)] * self.memory[self:getParam(mode2, 2)]
	self.pointer = self.pointer + 4
end

function IntCode:input(mode1)--, inputValue) -- OpCode 3
	if mode1 == 1 then mode1 = 0 end
	--print("input", self:getParam(mode1, 1))
	self.memory[self:getParam(mode1, 1)] = self:getInputValue()--inputValue--[self.nextInput]
	self.pointer = self.pointer + 2
	--self.nextInput = self.nextInput + 1
end

function IntCode:outputs(mode1) -- OpCode 4
	--if not(mode1 == 0) then mode1 = 0 end --desactivando esto funciona el dia 11R
	--print("outputs", self:getParam(mode1, 1))
	table.insert(self.output, self.memory[self:getParam(mode1, 1)])
	--self.output = self.memory[self:getParam(mode1, 1)]
	self.pointer = self.pointer + 2
	--self.nextInput = 1
end

function IntCode:jumpIfTrue(mode1, mode2) -- OpCode 5
	--print("jumpiftrue", self:getParam(mode1, 1), self:getParam(mode2, 2))
	if not(self.memory[self:getParam(mode1, 1)] == 0) then
		self.pointer = self.memory[self:getParam(mode2, 2)] + 1
	else
		self.pointer = self.pointer + 3
	end
end

function IntCode:jumpIfFalse(mode1, mode2) --OpCode 6
	--print("jumpiffalse", self:getParam(mode1, 1), self:getParam(mode2, 2))
	if self.memory[self:getParam(mode1, 1)] == 0 then
		self.pointer = self.memory[self:getParam(mode2, 2)] + 1
	else
		self.pointer = self.pointer + 3
	end
end

function IntCode:lessThan(mode1, mode2, mode3) --OpCode 7
	if mode3 == 1 then mode3 = 0 end
	--print("lessthan", self:getParam(mode1, 1), self:getParam(mode2, 2), self:getParam(mode3, 3))
	if self.memory[self:getParam(mode1, 1)] < self.memory[self:getParam(mode2, 2)] then
		self.memory[self:getParam(mode3, 3)] = 1
	else
		self.memory[self:getParam(mode3, 3)] = 0
	end
	self.pointer = self.pointer + 4
end

function IntCode:equals(mode1, mode2, mode3) --OpCode 8
	--print("equals", self:getParam(mode1, 1), self:getParam(mode2, 2), self:getParam(mode3, 3))
	if mode3 == 1 then mode3 = 0 end
	if self.memory[self:getParam(mode1, 1)] == self.memory[self:getParam(mode2, 2)] then
		self.memory[self:getParam(mode3, 3)] = 1
	else
		self.memory[self:getParam(mode3, 3)] = 0
	end
	self.pointer = self.pointer + 4
end

function IntCode:adjustsBaseRelative(mode1) -- OpCode 9
	--if mode3 == 1 then mode3 = 0 end
	--print("adjustsBaseRelative", self:getParam(mode1, 1))
	self.baseRelative = self.baseRelative + self.memory[self:getParam(mode1, 1)]
	self.pointer = self.pointer + 2
end

function IntCode:getParam(mode, parameter)
	if mode == 0 then
		return self:positionParam(parameter)
	elseif mode == 1 then
		return self:inmediateParam(parameter)
	elseif mode == 2 then
		return self:relativeParam(parameter)
	else
		error("modo de parametro desconocido")
	end
end

function IntCode:adjustParameter(p)
	if p < 0 then error("parametro es menor que cero", p) end
	if self.memory[p] == nil then
		self.memory[p] = 0
	end
end

function IntCode:inmediateParam(p)
	self:adjustParameter(self.pointer + p)
	return self.pointer + p
end

function IntCode:positionParam(p) -- integer
	--p = p or error("Parametro no existe en la memoria")
	self:adjustParameter(self.memory[self.pointer + p] + 1)
	return self.memory[self.pointer + p] + 1
end

function IntCode:relativeParam(p)
	self:adjustParameter(self.memory[self.pointer + p] + self.baseRelative + 1)
	return self.memory[self.pointer + p] + self.baseRelative + 1
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

function IntCode:run(inputValue, out)
	if not(inputValue == nil) then self:addInputValue(inputValue) end
	while true do
		local opCode, mode1, mode2, mode3 = self:decodePointerMemory()
		if opCode == 1 then self:add(mode1, mode2, mode3)
		elseif opCode == 2 then self:multiply(mode1, mode2, mode3)
		elseif opCode == 3 then self:input(mode1)--, inputValue)
		elseif opCode == 4 then self:outputs(mode1) if out then return self:getOutput() end-- Devolvemos resultado
		elseif opCode == 5 then self:jumpIfTrue(mode1, mode2)
		elseif opCode == 6 then self:jumpIfFalse(mode1, mode2)
		elseif opCode == 7 then self:lessThan(mode1, mode2, mode3)
		elseif opCode == 8 then self:equals(mode1, mode2, mode3)
		elseif opCode == 9 then self:adjustsBaseRelative(mode1)
		elseif opCode == 99 then self.stopped = true break --return self.output -- Detenemos el programa
		else print("ultimo opCode: " .. tostring(opCode)) error("no existe opCode")
		end
	end
end
return IntCode