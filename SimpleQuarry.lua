length = 10
width = 10
otherWay = false
x = 0
y = 0
currentDir = "N"
lastx = 1
lasty = 1
lastDir = "N"
OVERWORLDJUNK = {"minecraft:dirt", "minecraft:cobblestone", "minecraft:gravel"}
NETHERJUNK = {"minecraft:netherrack", "minecraft:gravel"}
HASJUNK = false
FULL = true
QUARRYMODE = ""

-- Initialize Tables that will handle compass directions and a bespoke coordinate system

LEFT = {}
RIGHT = {}
MOVEVALUES = {}

RIGHT["N"] = "E"
RIGHT["E"] = "S"
RIGHT["S"] = "W"
RIGHT["W"] = "N"

LEFT["N"] = "W"
LEFT["W"] = "S"
LEFT["S"] = "E"
LEFT["E"] = "N"

MOVEVALUES["N"] = 1
MOVEVALUES["S"] = -1
MOVEVALUES["E"] = 1
MOVEVALUES["S"] = -1

-- Functions

function digS()
	while turtle.detect() do
		turtle.dig()
	end
	turtle.forward()
	turtle.digUp()
	turtle.digDown()
end

function compass(current, direction)

	if direction == "right" then
		return RIGHT[current]
	elseif direction == "left" then
		return LEFT[current]
	end
end

function updateCoords(current, direction)

	local newX = current + MOVEVALUES[direction]
	return newX

end

function initialize()
	io.write("Initializing Simple Quarry\n")
	io.write("Please put a bucket of lava in the first slot\n")
	io.write("Please enter the length of the quarry: \n")
	length = tonumber(io.read())
	io.write("Please enter the width of the quarry: \n")
	width = tonumber(io.read())
	io.write("Please enter the mode of quarry: \n")
	io.write("1 = Overworld\n2 = Nether\n")
	QUARRYMODE = io.read()
	QUARRYMODE = tonumber(QUARRYMODE)
	if QUARRYMODE == 1 then
		mode = "overworld"
	elseif QUARRYMODE == 2 then
		mode = "nether"
	end
	io.write("Starting Quarry\n")
	digS()
	x = 1
	y = 1
	currentDir = "N"
end

function home(direction)

	lastx = x
	lasty = y
	lastDir = currentDir
	if direction == "S" then
		turtle.turnRight()
		direction = compass(direction, "right")
	elseif direction == "N" then
		turtle.turnLeft()
		direction = compass(direction, "left")
	elseif direction == "E" then
		turtle.turnLeft()
		direction = compass(direction, "left")
		turtle.turnLeft()
		direction = compass(direction, "left")
	end
	for i = x, 1, -1 do
		turtle.forward()
		x = updateCoords(x, direction)
	end
	turtle.turnLeft()
	currentDir = compass(direction, "left")
	for i = y, 1, -1 do
		turtle.forward()
		y = updateCoords(y, direction)
	end
	turtle.forward()
end

function deposit()
	for l = 2, 16 do
		turtle.select(l)
		turtle.drop()
	end
	turtle.turnRight()
	currentDir = compass(currentDir, "right")
	turtle.turnRight()
	currentDir = compass(currentDir, "right")
	turtle.forward()
end

function resume()
	for i = x, lastx do
		turtle.forward()
		x = updateCoords(x, currentDir)
	end
	turtle.turnRight()
	currentDir = compass(currentDir, "right")
	for j = y, lasty do
		turtle.forward()
		y = updateCoords(y, currentDir)
	end
	if lastDir == "N" then
		turtle.turnLeft()
		currentDir = compass(lastDir, "left")
	elseif lastDir == "S" then
		turtle.turnRight()
		currentDir = compass(lastDir, "right")
	end
end

function removeJunk(mode)
	turtle.select(1)
	turtle.placeDown()
	for i = 2, 16 do
		turtle.select(i)
		if mode == "overworld" then
			for j = 1, #OVERWORLDJUNK do
				if turtle.getItemDetail(i)["name"] == OVERWORLDJUNK[j] then
					turtle.dropDown()
					HASJUNK = true
				end
			end
		elseif mode == "nether" then
			for j = 1, #NETHERJUNK do
				if turtle.getItemDetail(i)["name"] == NETHERJUNK[j] then
					turtle.dropDown()
					HASJUNK = true
				end
			end
		end
	end
end

function checkInventory()
	for l = 2, 16 do
		if turtle.getItemCount(l) == 0 then
			return false
		end
	end
	return true
end

-- Main Driver

initialize()
for i = 1, width do
	for j = 1, length-1 do
		digS()
		x = updateCoords(x, currentDir)
		FULL = checkInventory()
		if FULL == true then
			removeJunk(mode)
			if HASJUNK == false then
				home(currentDir)
				deposit()
				resume()
			end
			HASJUNK = false
		end
	end

	if i ~= width then
		if currentDir == "N" then
			turtle.turnRight()
			currentDir = compass(currentDir, "right")
			digS()
			x = updateCoords(x, currentDir)
			turtle.turnRight()
			currentDir = compass(currentDir, "right")
		elseif currentDir == "S" then
			turtle.turnLeft()
			currentDir = compass(currentDir, "left")
			digS()
			x = updateCoords(x, currentDir)
			turtle.turnLeft()
			currentDir = compass(currentDir, "left")
			end
		else
			home(currentDir)
			deposit()
		end
end