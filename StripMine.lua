local counter = 0

function minePil()
	turtle.dig()
	turtle.digUp()
	turtle.digDown()
end

function torch()
	turtle.turnLeft()
	turtle.placeUp()
	turtle.turnRight()
end

local function digStrip(deep)
	for i=1,deep do
		minePil()
		counter = counter + 1
		if counter == 8 then
			torch()
			counter = 0
		end
	end
end

local function home(deep, rl)
	turtle.turnRight()
	turtle.turnRight()
	for i=1, deep do
		turtle.forward()
	end
	if rl == "l" then		turtle.turnRight()
	elseif rl == "r" then
		turtle.turnLeft()
	end
end

local function toNext(rl)
	turtle.forward()
	turtle.forward()
	if rl == "l" then
		turtle.turnRight()
	elseif rl == "r" then
		turtle.turnLeft()
	end
end

io.write("Mineshaft amount: ")
local comstrips = io.read()
comstrips = tonumber(comstrips)

sleep(1)
print()

io.write("Mineshaft depth: ")
local depth = io.read()
depth = tonumber(depth)


sleep(1)
print()

io.write("New mineshaft direction (L or R): ")
local rl = io.read()
rl = tostring(rl)
rl = string.lower(rl)

sleep(1)
print()

turtle.select(1)
print("Starting now...")

for j = 1, comstrips do
	digStrip(depth)
	home(depth, rl)
	if j < comstrips then
		toNext(rl)
	end
end


