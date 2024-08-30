-- Excavator Program to dig a rectangular tunnel

-- Description: Asks for dimensions m by n by o. Makes sure fuel is above 2000.
-- Empties inventory. Picks up torches. Starting from a corner digs m across and
-- moves up, empties inventory, increase n then repeats.

-- To Do
-- 1. Asks for dimensions (m by n o)
-- 1a. Calculates number of blocks and fuel needed
-- 2. Refuel.
-- 3. Collects torches.
-- 4. Digs m by o.
-- 5. Empties inventory.
-- 6. Increase n.
-- 7. Repeats from step 4.
-- 8. Returns to start.

-- Variables --
Torches = 1
Fuel = 2
Blocks = 2

-- Function --
-- Input Function
function Input()
    io.write("Input width m: ")
    local m = io.read()
    io.write("Input length n: ")
    local n = io.read()
    io.write("Input height o: ")
    local o = io.read()
    return m, n, o
end

-- Calculation Function
function Calculation(m, n, o)
    local b = m * n * o
    local f = math.ceil((b+10)/80)
    local t = (math.ceil(n/5)) * 3
    return b, f, t
end

-- Move Functions
function Move()
    while turtle.detect() == true do
        turtle.dig()
    end
    turtle.forward()
end

function MoveUp()
    turtle.digUp()
    turtle.up()
end

function MoveDown()
    turtle.digDown()
    turtle.down()
end

-- Empties Inventory Function
function EmptyInventory()
    for x=2, 16, 1 do
      turtle.select(x)
      turtle.drop()
    end
    turtle.select(Blocks)
end

-- Refuel and collect torches Function
function Inventory(b, f, t)
    -- Empty inventory
    turtle.turnRight()
    turtle.turnRight()
    for i = 1, 16, 1 do
      turtle.select(i)
      turtle.drop()
    end

    -- Pickup Fuel
    turtle.turnLeft()
    Move()
    turtle.turnRight()
    turtle.select(Fuel)
    turtle.suck(64)
    while turtle.getFuelLevel() < (b * 2) do
        turtle.refuel(1)
    end
    turtle.drop()

    -- Pickup Torches
    turtle.turnLeft()
    Move()
    turtle.turnRight()
    turtle.select(Torches)
    turtle.suck(t)

    -- Returns to start
    turtle.turnRight()
    Move()
    Move()
    turtle.turnRight()
    turtle.turnRight()

    print("Ready to Excavate")
end

-- Place Torches Function

-- Dig Function
function Dig(m, y, o)

    -- Basic Dig
    for j=1, m, 1 do
        for k=1, o-1, 1 do
            MoveUp()
        end
        for k=1, o-1, 1 do
            MoveDown()
        end
        Move()
    end

    turtle.back()
    turtle.select(Blocks)
    turtle.place()

    -- Placing torches at intervals
    for j=2, m, 1 do
        turtle.back()
        if (j % 4 == 0) and (y % 5 == 0) then
            turtle.select(Torches)
            turtle.place()
        end
    end

    -- Empty Inventory every 5 n
    if (y % 5 == 0) then
        turtle.turnRight()
        for i=0, y, 1 do
            if i ~= 0 then
                turtle.forward()
            end
        end

        EmptyInventory()
        turtle.turnLeft()
        turtle.turnLeft()
        for i=1, y-1, 1 do
            Move()
        end
        turtle.turnRight()
    end
end

-- Main --
M, N, O = Input()
blockCount, fuelCount, torchCount = Calculation(M, N, O)

print("---------------------------------------")
print("Number of blocks: ".. tostring(blockCount))
print("Fuel needed: ".. tostring(fuelCount))
print("Torches needed: ".. tostring(torchCount))
print("---------------------------------------")

Inventory(blockCount, fuelCount, torchCount)
for i=1, N, 1 do
    Dig(M, i, O)
    turtle.turnLeft()
    Move()
    turtle.turnRight()
end
