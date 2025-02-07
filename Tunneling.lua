local counter = 0

local function tunnelSection()
	local function digPillar()
		turtle.dig()
		turtle.forward()
		turtle.digUp()
		turtle.digDown()
	end
	digPillar()
	turtle.turnLeft()
	digPillar()
	turtle.turnRight()
	turtle.turnRight()
	turtle.forward()
	digPillar()
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnRight()
end

local function torchSection()
	turtle.turnLeft()
	turtle.forward()
	turtle.placeUp()
	turtle.turnRight()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
end

print("Depth: ")
local depth = io.read()
depth = tonumber(depth)

turtle.select(1)

print("Tunneling 3x3 with depth: " .. depth)

sleep(1)

print("Starting in: ")
print("3")
sleep(1)
print("2")
sleep(1)
print("1")
sleep(1)
print("Tunneling now!")

for 1, depth do
	tunnelSection()
	counter = counter + 1
	if counter==8 then
		torchSection()
		counter = 0
	end
end
