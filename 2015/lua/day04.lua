local file = io.open("day04input.txt", "r")
local text = file:read("*a")
file:close()

local function split(str, del) --String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local lines = split(text, "[^\n]+")

local function isNice(word)
	local aeiou = {"a", "e", "i", "o", "u"}
	local strings = {"ab", "cd", "pq", "xy"}
	-- it contains at least 3 vowels
	local vowelCount = 0
	for char in word:gmatch("%a") do
		for _, vowel in ipairs(aeiou) do
			if char == vowel then
				vowelCount = vowelCount + 1
			end
		end
		if vowelCount > 2 then break end
	end
	if vowelCount < 3 then return false end
	-- it contains at least 1 letter that appears twice in a row
	local twice = false
	for i=1, #word-1 do
		if word:sub(i,i) == word:sub(i+1,i+1) then
			twice = true
			break
		end
	end
	if not twice then return false end
	-- it does not contain strings
	local contains = false
	for i=1, #word-1 do
		for _, chars in ipairs(strings) do
			if word:sub(i, i+1) == chars then
				contains = true
				break
			end
		end
	end
	return not contains
end

local function isNice2(word)
	local pairCount = 0
	for i=1, #word-1 do
		for i2 =1, #word-1 do
			if not (i == i2) then
				if word:sub(i,i+1) == word:sub(i2, i2+1) then
					pairCount = pairCount + 1
				end
			end
		end
	end
	if not(pairCount == 1) then return false end
	local between = false
	for i=1, #word-2 do
		if word:sub(i,i) == word:sub(i+2,i+2) then
			between = true
		end
	end
	return between
end

local function answer1()
	local result = 0
	for _, word in ipairs(lines) do
		if isNice(word) then
			result = result + 1
		end
	end
	return result
end

local function answer2()
	local result = 0
	for _, word in ipairs(lines) do
		if isNice2(word) then
			result = result + 1
		end
	end
	return result
end
print(isNice2("qjhvhtzxzqqjkmpb"))
print("the answer 1 is", answer1())
print("the answer 2 is", answer2())