-- Lumberjack Program --
-- Description: 20 by 20 grid, trees placed with a 4 block gap, so 4 by 4 set of
-- trees. Checks all 16 saplings, if grown it will cut down the whole tree.
-- Picking up only logs and saplings. Then returning to the chest and dropping
-- off logs and saplings to have 16. Each tree is replanted. Grabs fuel and
-- refuels.

-- To do List:
-- 1. Checks to see if sapling is grown.
-- 2. Cuts down grown trees.
-- 3. Picks up any dropped items.
-- 4. Replants saplings.
-- 5. Drops off logs in chest.
-- 6. Discards unwanted items.

-- Variables --
Sapling = 1
Log = 2
Fuel = 3

count = 0

-- Functions --
-- Move Forward Function
function Move()
    while turtle.detect() == true do
        turtle.dig()
    end
    turtle.forward()
end

-- Tree Column
function TreeCut()
    for i=0, 3, 1 do
        Move()
        Move()
        turtle.turnRight()
        turtle.select(Sapling)
        if turtle.compare() == false then

            turtle.select(Log)
            if turtle.compare() == true then
                -- Cut Tree
                print("Cutting Tree...")
                count = 0
                Move()
                while turtle.detectUp() == true do
                    turtle.digUp()
                    turtle.up()
                    for z=0, 3, 1 do
                        if turtle.compare() == true then
                            Move()
                            Move()
                            turtle.back()
                            turtle.back()
                        end
                        --turtle.dig()
                        turtle.turnRight()
                    end
                    count = count + 1
                end
                for y=0, count, 1 do
                    turtle.down()
                end
                turtle.back()
                turtle.select(Sapling)
                turtle.place()
            else
                -- Missing sapling, place sapling
                turtle.select(Sapling)
                print("Planting sapling")
                turtle.place()
            end
        end

        turtle.turnLeft()
        Move()
        Move()
        Move()
    end
end

-- Turn Right
function RightTurn()
    turtle.turnRight()
    for x=0, 6, 1 do
        Move()
    end
    turtle.turnRight()
    Move()
end

-- Turn Left
function LeftTurn()
    turtle.turnLeft()
    for x=0, 2, 1 do
        Move()
    end
    turtle.turnLeft()
    Move()
end

-- Return Function
function Reset()
    -- Move to start
    turtle.turnRight()
    for x=0, 15, 1 do
        Move()
    end

    -- Empty Inventory
    turtle.turnLeft()
    for i = 2, 16, 1 do -- Rest into crate
      turtle.select(i)
      turtle.drop()
    end
    turtle.select(Log)
    turtle.suck(1)    -- Collects 1 log for comparisons

    -- Fuel
    if turtle.getFuelLevel() < 1500 then
        turtle.turnLeft()
        Move()
        turtle.turnRight()
        turtle.select(Fuel)
        turtle.suck()      -- Picks up fuel
        while turtle.getFuelLevel() < 1500 do    -- Refuel rest
            turtle.refuel(1)
        end
        turtle.drop()
        turtle.turnRight()
        Move()
        turtle.turnLeft()
    end

    -- Sapling
    turtle.turnRight()
    Move()
    turtle.turnLeft()
    turtle.select(Sapling)
    turtle.drop()           -- Drops all saplings
    turtle.suck(17)         -- Collects 17
    turtle.turnRight()
    turtle.turnRight()
    Move()                  -- Starting position
end

-- Main --
while true do
    --turtle.select(Fuel)
    --while turtle.getFuelLevel() < 500 do
        --turtle.refuel(1)
    --end

    os.sleep(30)
    TreeCut()
    RightTurn()
    TreeCut()
    LeftTurn()
    TreeCut()
    RightTurn()
    TreeCut()

    Reset()
end
