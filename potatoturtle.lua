# FIXED Needs to empty full chest.
# FIXED Needs to make sure he moves (half done. also with turns)
# FIXED I think... Fix glitch that cause him to skip some crops. (Proposing checking if he successfully completed his tasks before moving on)

function amIHomeYet()
    blingsuc, blingdat = turtle.inspectDown()
    if blingdat.name == "chisel:diamond_block" then
        return true
    else
        return false
    end
end   

function secureMove(direction)
    if (direction == "forward") then
        while (not turtle.forward()) do
            os.sleep(1)
        end
    elseif (direction == "back") then
        while (not turtle.back()) do
            os.sleep(1)
        end
    end
end

function secureHarvestAndPlant()
    local secsuccess, secdata = turtle.inspectDown()
    if (secdata.metadata == 7) then
        while (not turtle.digDown()) do
            os.sleep(1)
        end
        while (not turtle.placeDown()) do
            os.sleep(1)
        end
    elseif (not secsuccess) then
        while (not turtle.placeDown()) do
            turtle.digDown()
            os.sleep(0.3)
        end
    end
end

function moveyoudumbfuckingturtle()
    for i=1,8 do
        secureHarvestAndPlant()
        secureMove("forward")
    end
end
  
function turn()
    if nextRight == 1 then
        turtle.turnRight()
        secureHarvestAndPlant()
        secureMove("forward")
        turtle.turnRight()
        nextRight = 0    
    else
        turtle.turnLeft()
        secureHarvestAndPlant()
        secureMove("forward")
        turtle.turnLeft()
        nextRight = 1
    end
end

function hibernate()
    rest = true
    while (rest == true) do
        os.sleep(10)
        local success, data = turtle.inspectDown()
        if data.metadata == 7 then
            rest = false
        end
    end
end

function backToHub()
    turtle.turnRight()
    secureMove("forward")
    turtle.turnRight()
    for i=1,17 do 
        secureMove("forward")
    end
    turtle.turnRight()
    for i = 16,2,-1 do
        turtle.select(i)
        turtle.dropUp()
    end
    turtle.select(1)
    secureMove("forward")
    nextRight = 1
end


while (1 == 1) do
    backToHub()
    while (not amIHomeYet()) do
        moveyoudumbfuckingturtle()
        turn() 
    end
    turtle.turnRight()
    secureMove("back")
    hibernate()
end
