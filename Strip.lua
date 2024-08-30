-- Strip Mining Turtle Program --

-- Description: mines 10 by 2 blocks forward, then turns left mines 2 by 2 and
-- places a torch. Then returns back to the end of the strip and repeats until
-- inventory is full. Returns back to where it started and places everything in
-- chest, and refills fuel and torches.

-- Todo List:
-- 1. Refuels from chest and fill torches (right).
-- 1a. Check inventory is correct.
-- 2. Mines strip 10 blocks forward (10 by 2).
-- 3. Mines connecting tunnel (2 by 2) left.
-- 3a. Places torch in connecting tunnel.
-- 4. Returns to chest to empty inventory (left), refuel, and refill torches.

-- Variables --
Fuel = 1
Torches = 2
Bool = true

-- Functions --

-- Strip Mine Right
function StripMineRight(T)

    local countBlock = 0

    for x = 0, 9, 1 do
        print(x)
        -- Step 2 - Mine strip
        print("Ready to mine")
        for i = 0, 9, 1 do
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

        if T == true then
            turtle.select(Torches)
            turtle.turnRight()
            turtle.placeUp()
            turtle.turnLeft()
        end

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
function StripMineLeft(T)

    local countBlock = 0

    for x = 0, 9, 1 do
        print(x)
        -- Step 2 - Mine strip
        print("Ready to mine")
        for i = 0, 9, 1 do
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

        if T == true then
            turtle.select(Torches)
            turtle.turnLeft()
            turtle.placeUp()
            turtle.turnRight()
        end

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

function Inventory(f, t)
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
    -- Collect Torches
    turtle.forward()
    turtle.select(Torches)
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

    turtle.select(Torches)
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
Inventory(fuelNeeded, tourchNeeded)

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

    -- Toggle Torches
    Bool = not Bool
end

print("Strip mine finished")
