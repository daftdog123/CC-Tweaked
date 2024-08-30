-- TNT setup Turtle Program --

-- Description: Places TNT every 5 tiles of the previously dug strip mine

-- Todo List:
-- 1. Picks up required TNT and fuel.
-- 2. Heads down mine shaft.
-- 3. Returns down the way it came placing TNT every 5 tiles
-- 4. Repeats steps 2 to 3 for the rest of the mines

-- Variables --
Fuel = 1
TNT = 2

-- Functions --

-- Strip Mine Right
function StripMineRight()

    local countBlock = 0

    for x = 0, 19, 1 do
        print(x)
        -- Step 2 - Mine strip
        print("Ready to mine")
        for i = 0, 4, 1 do
            --print(i)
            while turtle.detect() == true do    -- Anti Gravel
                turtle.dig()
            end

            turtle.forward()
            turtle.digUp()

            countBlock = countBlock + 1
        --print("Done")
        end

        -- Step 3 - Mine connection
        print("Digging Connection")
        turtle.turnLeft()
        for i = 0, 1, 1 do
            print(i)
            while turtle.detect() == true do
                turtle.dig()
            end
            turtle.forward()
            turtle.digUp()
        end

        turtle.turnLeft()
        turtle.turnLeft()
        while turtle.detect() == true do    -- Anti Gravel
            turtle.dig()
        end
        turtle.forward()

        -- Place TNT
        turtle.select(TNT)
        turtle.turnRight()
        turtle.turnRight()
        turtle.place()
        turtle.turnLeft()
        turtle.turnLeft()

        turtle.forward()
        turtle.turnLeft()
    end

    -- Step 4 - Return
    turtle.turnLeft()
    turtle.turnLeft()
    for x = 1, countBlock, 1 do
        --print(x)
        while turtle.detect() == true do    -- Anti Gravel
            turtle.dig()
        end
        turtle.forward()
    end
end

-- Strip Mine Left
function StripMineLeft()

    local countBlock = 0

    for x = 0, 19, 1 do
        print(x)
        -- Step 2 - Mine strip
        print("Ready to mine")
        for i = 0, 4, 1 do
            --print(i)
            while turtle.detect() == true do    -- Anti Gravel
                turtle.dig()
            end

            turtle.forward()
            countBlock = countBlock + 1
            turtle.digUp()
        --print("Done")
        end

        -- Step 3 - Mine connection
        print("Digging Connection")
        turtle.turnRight()
        for i = 0, 1, 1 do
            print(i)
            while turtle.detect() == true do
                turtle.dig()
            end
            turtle.forward()
            turtle.digUp()
        end

        turtle.turnRight()
        turtle.turnRight()
        while turtle.detect() == true do    -- Anti Gravel
            turtle.dig()
        end
        turtle.forward()

        -- Place TNT
        turtle.select(TNT)
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.place()
        turtle.turnRight()
        turtle.turnRight()

        turtle.forward()
        turtle.turnRight()
    end

    -- Step 4 - Return
    turtle.turnLeft()
    turtle.turnLeft()
    for x = 1, countBlock, 1 do
        --print(x)
        while turtle.detect() == true do    -- Anti Gravel
            turtle.dig()
        end
        turtle.forward()
    end
end

function Inventory()
    -- Empty Inventory
    turtle.turnLeft()
    turtle.forward()
    for i = 1, 16, 1 do
      turtle.select(i)
      turtle.dropDown()
    end
    -- Refueling - Takes 24 fuel units to complete 1 section of a strip
    turtle.turnRight()
    turtle.turnRight()
    turtle.forward()
    turtle.select(Fuel)
    turtle.suckDown(64)
    while turtle.getFuelLevel() < 1200 do
        turtle.refuel(1)
    end
    turtle.dropDown()
    -- Collect TNT
    turtle.forward()
    turtle.select(TNT)
    while turtle.getItemCount() ~= 64 do
        turtle.suckDown(1)
    end
    -- Returns to start
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
end

function InventoryEmpty()
    print("Emptying Inventory")
    turtle.turnLeft()
    turtle.forward()
    turtle.select(1)
    turtle.dropDown()
    for i = 3, 16, 1 do
      turtle.select(i)
      turtle.dropDown()
    end
    turtle.turnRight()
    turtle.turnRight()
    turtle.forward()

    turtle.select(TNT)
    if turtle.getItemCount() < 10 then
        turtle.forward()
        while turtle.getItemCount() ~= 64 do
            turtle.suckDown(1)
        end
        turtle.back()
    end
    turtle.turnLeft()
end

-- Main --

-- Sort Inventory
Inventory()

for y = 0, 4, 1 do
    print("Mining Strip: "..tostring(y))
    -- Strip Right
    print("Right Side")
    for z = 0, y, 1 do
        turtle.forward()
        turtle.forward()
        turtle.forward()
    end

    turtle.turnRight()
    turtle.forward()
    turtle.forward()

    StripMineRight(Bool)
    turtle.forward()
    turtle.forward()

    turtle.turnLeft()

    for z = 0, y, 1 do
        turtle.forward()
        turtle.forward()
        turtle.forward()
    end

    turtle.turnRight()
    turtle.turnRight()

    -- Empty Inventory
    InventoryEmpty()

    -- Strip Left
    print("Left Side")
    for z = 0, y, 1 do
        turtle.forward()
        turtle.forward()
        turtle.forward()
    end

    turtle.turnLeft()
    turtle.forward()
    turtle.forward()

    StripMineLeft(Bool)
    turtle.forward()
    turtle.forward()

    turtle.turnRight()

    for z = 0, y, 1 do
        turtle.forward()
        turtle.forward()
        turtle.forward()
    end

    turtle.turnRight()
    turtle.turnRight()

    -- Empty Inventory
    InventoryEmpty()

end

print("Strip mine finished")
