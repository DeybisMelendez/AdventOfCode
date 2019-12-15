file = io.open("Dia11.txt", "r") -- Se requiere un archivo Dia11.txt para ejecutar
local text = file:read("*a")
file:close()

-- Funciones
-- Funcion que divide una cadena de texto con un delimitador
local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, tonumber(value))
    end
    return t
end
local function copyTable(t)
    local n = {}
    for i, v in pairs(t) do
        n[i] = v
    end
    return n
end
local input = split(text, "[^,]+")

local function newIntCode(i)
    local t = {}
    t.input = copyTable(i)
    t.nextInput = 1
    --t.i = i1 --tabla con los inputs
    t.pointer = 1
    t.baseRelative = 0
    --t.i2 = i2
    function t:intCode(inputValue) --inputValue debe ser una tabla
        --self.i = self.i or inputValue
		if not (inputValue == nil) then table.insert(self.inputValue, inputValue) end
        local opCode
        while true do
            local code = tostring(self.input[self.pointer])
            for _=1, 5-(code:len()) do
                code = "0" .. code
            end
            opCode = tonumber(code:sub(code:len()-1, code:len()))
            if opCode == 99 then return end --input[input[pointer+1]+1] end
            local param1, param2, param3-- parametro 3 tecnicamente no requiere modo inmediato
            -- Modos
            --TODO agregar modo 2 a los parametros
            --parametro 1
	            if tonumber(code:sub(3,3)) == 2 then
	                param1 = self.input[self.pointer+1]+1 + self.baseRelative
	            elseif tonumber(code:sub(3,3)) == 1 then
	                param1 = self.pointer+1
	            elseif tonumber(code:sub(3,3)) == 0 then
	                param1 = self.input[self.pointer+1]+1
	            end
            --parametro 2
            if opCode ~= 4 and opCode ~= 3 then
                if tonumber(code:sub(2,2)) == 2 then
                    param2 = self.input[self.pointer+2]+1 + self.baseRelative
                elseif tonumber(code:sub(2,2)) == 1 then
                    param2 = self.pointer+2
                elseif tonumber(code:sub(2,2)) == 0 then
                    param2 = self.input[self.pointer+2]+1
                end
            end
            --parametro 3
            if opCode ~= 4 and opCode ~= 5 and opCode ~=6 and opCode ~= 9 then
                if tonumber(code:sub(1,1)) == 2 then
                    param3 = self.input[self.pointer+3]+1 + self.baseRelative
                end
                if tonumber(code:sub(1,1)) == 1 then
                    param3 = self.pointer+3
                elseif tonumber(code:sub(1,1)) == 0 then
                    param3 = self.input[self.pointer+3]+1
                end
            end
            -- OP CODES
            --local continue = false
            if opCode == 1 then
                self.input[param3] = self.input[param1] + self.input[param2]
                self.pointer = self.pointer + 4
            elseif opCode == 2 then
                self.input[param3] = self.input[param1] * self.input[param2]
                self.pointer = self.pointer + 4
            -- nuevas instrucciones PARTE 1
            elseif opCode == 3 then
				--if inputValue[self.nextInput] == nil then return end
                self.input[param3] = self.inputValue[self.nextInput]
                self.nextInput = self.nextInput+1
                self.pointer = self.pointer + 2
            elseif opCode == 4 then
                -- self.input = input
                -- self.nextInput = nextInput
                self.pointer = self.pointer + 2
                return self.input[param1]--input[input[pointer+1]+1]
            -- Nuevas instrucciones PARTE 2
            elseif opCode == 5 then
                if not (self.input[param1] == 0) then
                    self.pointer = self.input[param2]+1
                else
                    self.pointer = self.pointer + 3
                end
            elseif opCode == 6 then
                if self.input[param1] == 0 then
                    self.pointer = self.input[param2]+1
                else
                    self.pointer = self.pointer + 3
                end
            elseif opCode == 7 then
                if self.input[param1] < self.input[param2] then
                    self.input[param3] = 1
                else
                    self.input[param3] = 0
                end
                self.pointer = self.pointer + 4
            elseif opCode == 8 then
                if self.input[param1] == self.input[param2] then
                    self.input[param3] = 1
                else
                    self.input[param3] = 0
                end
                self.pointer = self.pointer + 4
            elseif opCode == 9 then
                self.baseRelative = self.baseRelative + self.input[param1]
                --if self.baseRelative < 0 then self.baseRelative = 0 end
                self.pointer = self.pointer + 2
            else
                error("opCode desconocido: " .. opCode)
            end
        end
    end
    return t
end

local function tableHasPos(t, v)
	for _, value in pairs(t) do
		if value.x == v.x and value.y == v.y then
			return value.color
		end
	end
	return 0
end

local robot = newIntCode(input)
robot.results = {}
robot.direction = {{x=0,y=1}, {x=1,y=0}, {x=0,y=-1}, {x=-1,y=0}}-- arriba, derecha, abajo, izquierda
robot.actualDir = 1 -- direction index 1 up
robot.pos = {x=0,y=0, color = 0}
robot.map = {}
for _=1, 10 do
	local t = {}
	for _=1, 10 do
		table.insert(t, 0)
	end
	table.insert(robot.map, t)
end
print("map creado")
function robot:paint()
	local newColor, nextDir, color
	local tcolor = {}
	while true do
		color = tableHasPos(self.results, self.pos)
		--Obtenemos los nuevos valores
		newColor = self:intCode(color)
		nextDir = self:intCode()
		print(newColor)
		print(nextDir)
		--if true then return end
		--pintamos
		if newColor == nil then break end
		self.pos.color = newColor
		table.insert(self.results, self.pos)
		--self.map[self.pos.x][self.pos.y] = newColor
		-- guardamos el camino si no hemos pasado por ese punto
		--local pos = {x = self.pos.x, y = self.pos.y}
		--if not tableHasPos(self.results, pos) then
		--	table.insert(self.results, pos)
			--print(#self.results)
		--end
		--movemos
		if nextDir == nil then break end
		if tonumber(nextDir) == 0 then nextDir = -1 end
		if nextDir ~= 1 then error("nextDir no es igual a 1", nextDir) end
		print(nextDir)
		self.actualDir = self.actualDir + nextDir
		if self.actualDir <= 0 then
			self.actualDir = self.actualDir + #self.direction
		elseif self.actualDir > #self.direction then
			self.actualDir = self.actualDir - #self.direction
		end
		local step = {x = self.direction[self.actualDir].x, y = self.direction[self.actualDir].y}
		self.pos.x, self.pos.y = self.pos.x + step.x, self.pos.y + step.y
		print(self.pos.x, self.pos.y)
	end
	return #self.results
end

print("answer 1 is", robot:paint())