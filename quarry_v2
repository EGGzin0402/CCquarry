local tArgs = {...}
local size = tonumber(tArgs[1])
local meter = tonumber(tArgs[2])

local stepSize = size - 1
local area = size * size
local diggedLevel = 0

--To move forward and mine if interupted
function frwd(steps)  
    for i = 1, steps do 
        turtle.digUp()
        turtle.digDown()
        
        while not turtle.forward() do
            turtle.dig()
        end
    end
end

function right()
    turtle.turnRight()
    frwd(1)
    turtle.turnRight()
end

function left()
    turtle.turnLeft()
    frwd(1)
    turtle.turnLeft()
end

--Consumes minimum refuel
function refuel(limit)
    local fuel = turtle.getFuelLevel()
    
    while turtle.getFuelLevel() <= limit do
        local i = 1
        
        while i <= 16 do
            turtle.select(i)
            
            if turtle.getFuelLevel() <= limit then
                if turtle.refuel(0) then
                    print("\nTurtle> Consuming: ".."\""..turtle.getItemDetail().name.."\"")
                    turtle.refuel(1)
                    print("Turtle> Fuel: "..turtle.getFuelLevel())
                    fuel = turtle.getFuelLevel()
                    i = 0
                    
                elseif i == 16 then
                    if fuel == turtle.getFuelLevel() then
                        turtle.select(1)
                        return false
                    end
                end
            else
                turtle.select(1)
                return true
            end
            i = i + 1
        end
    end
end

function emptySlots() 
    local empty = 16  
     
    for i = 1, 16 do        
        if turtle.getItemCount(i) ~= 0 then
            empty = empty - 1
        end 
    end
    return empty   
end

function placeChest(slot)
    turtle.select(slot)
    
    turtle.turnLeft()
    turtle.turnLeft()
    
    --Places 1st chest
    turtle.dig()
    turtle.place()
    turtle.digUp()
    turtle.up()
    turtle.dig()
    turtle.down()
    
    turtle.turnLeft()
    frwd(1)
    turtle.turnRight()
    
    --Places 2nd chest
    turtle.dig()
    turtle.place()
    turtle.digUp()
    turtle.up()
    turtle.dig()
    turtle.down()
    
    turtle.turnRight()
    frwd(1)
    turtle.turnRight()
     
    print("\nTurtle> Deployed chest")
end

function dumpChest(returning)
    refuel((area + diggedLevel) * 2)
    
    if diggedLevel % 2 == 0 and diggedLevel ~= 0 then
		      if size % 2 ~= 0 then        
       	    frwd(stepSize)
            turtle.turnRight()
         	  frwd(stepSize)
         	  turtle.turnRight()
    		
		      else
			         turtle.turnLeft()
			         frwd(stepSize)
			         turtle.turnRight()
		      end
	   end
    
    for i = 1, diggedLevel - 1 do
        turtle.digUp()
        turtle.up()
    end
        
    turtle.turnLeft()
    turtle.turnLeft()
        
    for i = 1, 16 do
        turtle.select(i)
        
        if not turtle.refuel(0) then
            turtle.drop()
        end
    end
    turtle.select(1)
        
    print("\nTurtle> Emptyed inventory!")
      
    turtle.turnRight()
    turtle.turnRight()
    
    if returning then    
        for i = 1, diggedLevel - 1 do
            turtle.digDown()
            turtle.down()
        end
    
        if diggedLevel % 2 == 0 and diggedLevel ~= 0 then
            if size % 2 ~= 0 then        
                frwd(stepSize)
                turtle.turnRight()
                frwd(stepSize)
                turtle.turnRight()
    		
            else
				            turtle.turnRight()
				            frwd(stepSize)
				            turtle.turnLeft()
            end
        end
    end
end

--Main program
local chestThere = 0
for i = 1, 16 do
    if turtle.getItemCount(i) >= 2 then
        if turtle.getItemDetail(i).name == "minecraft:chest" then     
            chestThere = i
            break
        end
    end
end

refuel(6)
            
if chestThere ~= 0 then    
    placeChest(chestThere)
        
else
    print("\nTurtle> Please give me 2 normal") 
    print("Turtle> minecraft chest")
    print("\nTurtle> Enter which slot has the chest") 
    print("Turtle> or 0 to not deploy\n")
    term.write("You> ")
    local chestIn = tonumber(read())

    if chestIn == 0 then
        print("\nTurtle> Make sure there is a chest") 
        print("Turtle> behind the starting point")
    
    elseif chestIn ~= 0 then
        if turtle.getItemCount(chestIn) >= 2 then
            if turtle.getItemDetail(chestIn).name == "minecraft:chest" then
                placeChest(chestIn)
        
            else
                print("\nTurtle> Chest not found")
                print("Turtle> Terminating!")
                exit()
            end     
        else
            print("\nTurtle> Minimum 2 chest are required")
            print("Turtle> Terminating!")
            exit()
        end
    else 
        print("\nTurtle> Enter a value between 0 to 16")
        print("Turtle> Terminating!")
        exit()
    end
end

while diggedLevel <= meter - 1 do     
    if emptySlots() == 0 then
        print("\nTurtle> Inventory Full!")
        print("Turtle> Emptying inventory")
        
        dumpChest(true)
        print("\nTurtle> Continuing...")
    end 
   
    if turtle.getFuelLevel() <= area + 3 then 
        if not refuel(area + 3) then
            print("\nTurtle> Fuel: "..turtle.getFuelLevel().." < "..area)
            print("Turtle> Terminating! Low fuel")
            exit()
        end
    end
    
    if diggedLevel == 0 then
        turtle.digDown()
        turtle.down()
        
        diggedLevel = diggedLevel + 2

    else
        for i = 1, 3 do
            turtle.digDown()
            turtle.down()   
        end
        
        diggedLevel = diggedLevel + 3
    end
    
    if size % 2 == 0 then        
        for i = 1, size do
            frwd(stepSize)
            
            if diggedLevel % 2 ~= 0 then
                if i ~= size then
                    if i % 2 == 0 then
                        right()
                    else
                        left()
                    end
                end

            else
                if i ~= size then
                    if i % 2 == 0 then
                        left()
                    else
                        right()
                    end
                end	
            end
        end
    else    
        for i = 1, size / 2 do
            frwd(stepSize)
            right()
            frwd(stepSize)
            left()
        end 
        
        frwd(stepSize)
    end
    
    turtle.turnRight()
    turtle.turnRight()
    turtle.digUp()
    turtle.digDown()
    
    print("\nTurtle> Digged: "..diggedLevel.."/"..meter.." levels")    
end

dumpChest(false)
print("\nTurtle> Mining complete! Terminating!")
