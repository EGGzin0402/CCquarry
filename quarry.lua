turtle.refuel()

function clearScreen()
	term.clear()
	term.setCursorPos(1,1)
end

function setup()
	posX = 0
	posY = 0
	posZ = 0
	rotation = 0
	layerType = 0
	clearScreen()
	io.write("Quarry or bore? ")
	mineType = io.read()
	clearScreen()
	io.write("Rows: ")
	rows = io.read()
	io.write("Columns: ")
	columns = io.read()
	clearScreen()
	if mineType == "quarry" then
		io.write("Current 'y' level: ")
		iniY = io.read()
		iniY = tonumber (iniY)
		clearScreen()
	end
	start()
end

function info()
	clearScreen()
	print("Creating a " .. rows .. "x" .. columns .. " " .. mineType)
	print("Total distance: " .. posX + posY + posZ)
	print("X: " .. posX)
	print("Y: " .. posY)
	print("Z: " .. posZ)
	print("Rotation: " .. rotation)
	print("Layer Type: " .. layerType)
	print("Fuel level: " .. turtle.getFuelLevel())
end

function orientate()
	if rotation == 0 then
		turtle.turnLeft()
		rotation = 3
		info()
	elseif rotation == 1 then
		turtle.turnLeft()
		rotation = 0
		info()
		turtle.turnLeft()
		rotation = 3
		info()
	elseif rotation == 2 then
		turtle.turnRight()
		rotation = 3
		info()
	end
end

function recover()
	orientate()
	stepY = posY
	stepX = posX
	stepZ = posZ
	for posY = stepY - 1, 0, -1 do
		turtle.up()
		info()
	end
	for posX = stepX - 1, 0, -1 do
		turtle.forward()
		info()
	end
	turtle.turnLeft()
	for posZ = stepZ - 1, 0, -1 do
		turtle.forward()
		info()
	end
end

function digStraight()
	turtle.digDown()
	turtle.dig()
	turtle.dig()
	turtle.forward()
	if rotation == 0 then
		posZ = posZ + 1
	elseif rotation == 1 then
		posX = posX + 1
	elseif rotation == 2 then
		posZ = posZ - 1
	elseif rotation == 3 then
		posX = posX - 1
	end
	turtle.digUp()
	info()
end

function nextRow()
	if layerType == 0 then
		if rotation == 0 then
			turtle.turnRight()
			rotation = 1
			info()
			digStraight()
			turtle.turnRight()
			rotation = 2
			info()
		elseif rotation == 2 then
			turtle.turnLeft()
			rotation = 1
			info()
			digStraight()
			turtle.turnLeft()
			rotation = 0
			info()
		end
	elseif layerType == 1 then
		if rotation == 0 then
			turtle.turnLeft()
			rotation = 3
			info()
			digStraight()
			turtle.turnLeft()
			rotation = 2
			info()
		elseif rotation == 2 then
			turtle.turnRight()
			rotation = 3
			info()
			digStraight()
			turtle.turnRight()
			rotation = 0
			info()
		end
	end
end

function nextLayer()
	turtle.turnRight()
	if rotation == 0 then
		rotation = 1
		info()
	elseif rotation == 2 then
		rotation = 3
		info()
	end
	turtle.turnRight()
	if rotation == 1 then
		rotation = 2
		info()
	elseif rotation == 3 then
		rotation = 0
		info()
	end
	turtle.down()
	posY = posY + 1
	info()
	turtle.digDown()
	turtle.down()
	posY = posY + 1
	info()
	turtle.digDown()
	turtle.down()
	posY = posY + 1
	info()
	if layerType == 0 then
		layerType = 1
	elseif layerType == 1 then
		layerType = 0
	end
end

function layerMove()
	for c = columns, 1, -1 do
		for r = rows, 2, -1 do
			digStraight()
		end
		if c > 1 then
			nextRow()
		else
			turtle.digDown()
		end
	end
end

function quarry()
	turtle.digDown()
	turtle.down()
	posY = posY + 1
	info()
	turtle.digDown()
	turtle.down()
	posY = posY + 1
	info()
	while posY < iniY - 2 do
		layerMove()
		nextLayer()
	end
	recover()
end

function bore()
	turtle.up()
	posY = posY + 1
	info()
	turtle.dig()
	turtle.forward()
	posZ = posZ + 1
	info()
	turtle.digUp()
	layerMove()
	recover()
end

function start()
	if mineType == "quarry" then
		quarry()
	elseif mineType == "bore" then
		bore()
	else
		setup()
	end
end

setup()