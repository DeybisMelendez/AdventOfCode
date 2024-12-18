local hashLib = require "lib.sha2"
local aoc = require "lib.aoc"
local input = aoc.input.getInput()

local function answer1()
	local num = 0
	while true do
		local hash = hashLib.md5(input .. num):sub(1, 5)
		if hash == "00000" then
			return num
		end
		num = num + 1
	end
end

local function answer2()
	-- Es demasiado lento
	local num = 0
	while true do
		local hash = hashLib.md5(input .. num):sub(1, 6)
		if hash == "000000" then
			return num
		end
		num = num + 1
	end
end
print("the answer 1 is", answer1())
print("the answer 2 is", answer2())
