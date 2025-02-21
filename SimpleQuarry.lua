length = 10
width = 10
otherWay = false
x = 0
y = 0
currentDir = "N"
lastx = 1
lasty = 1
lastDir = "N"

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
	io.write("Please enter the length of the quarry: ")
	length = tonumber(io.read())
	io.write("Please enter the width of the quarry: ")
	width = tonumber(io.read())
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
	compass(direction, "left")
	for i = y, 1, -1 do
		turtle.forward()
		y = updateCoords(y, direction)
	end
	turtle.forward()
end

function deposit()
	for l = 3, 12 do
		turtle.select(l)
		turtle.drop()
	end
	turtle.turnRight()
	compass(currentDir, "right")
	turtle.turnRight()
	compass(currentDir, "right")
	turtle.forward()
end

function resume()
	for i = x, lastx do
		turtle.forward()
		x = updateCoords(x, currentDir)
	end
	turtle.turnRight()
	compass(currentDir, "right")
	for j = y, lasty do
		turtle.forward()
		y = updateCoords(y, currentDir)
	end
	if lastDir == "N" then
		turtle.turnLeft()
		compass(lastDir, "left")
	elseif lastDir == "S" then
		turtle.turnRight()
		compass(lastDir, "right")
	end
end

for i = 1, width do
	for j = 1, length-1 do
		digS()
		x = updateCoords(x, currentDir)
	end
	if currentDir == "N" then
		turtle.turnRight()
		compass(currentDir, "right")
		digS()
		x = updateCoords(x, currentDir)
		turtle.turnRight()
		compass(currentDir, "right")
	elseif currentDir == "S" then
		turtle.turnLeft()
		compass(currentDir, "left")
		digS()
		x = updateCoords(x, currentDir)
		turtle.turnLeft()
		compass(currentDir, "left")
	end
end