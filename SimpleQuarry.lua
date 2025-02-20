local length, width
local otherWay = false
local x, y
local currentDir = "N"

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

	return current = current + MOVEVALUES[direction]

end

for i = 1, width do
	
