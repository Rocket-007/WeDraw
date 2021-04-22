player = {
xPos = 0, yPos = 0, --Position of player
xVel = 0, yVel = 0, --Velocity of player
speed = 100, -- Acceleration speed of player
maxSpeed = 200, --Max speed of player
friction = 10, -- Deleceration of player
}
function player.checkKeys(dt)
if not (love.keyboard.isDown( "w" ) and
love.keyboard.isDown( "a" )) then --Check if both keys arent pressed at the same time.
if love.keyboard.isDown( "w" ) then
player.yVel = player.yVel -
(player.speed*dt) --Up
elseif love.keyboard.isDown( "s" ) then
player.yVel = player.yVel +
(player.speed*dt) --Down
end
end
if not (love.keyboard.isDown( "a" ) and
love.keyboard.isDown( "d" )) then --Check if both keys arent pressed at the same time.
if love.keyboard.isDown( "a" ) then
player.yVel = player.yVel -
(player.speed*dt) --Left
elseif love.keyboard.isDown( "d" ) then
player.yVel = player.yVel +
(player.speed*dt) --Right
end
end
end
function player.applyFriction (dt)
if player.xVel > 0 then
player.xVel = math.max(player.xVel-
player.friction*dt, 0) --Round to everything above 0, or 0 itself
elseif player.xVel < 0 then
player.xVel = math.min(player.xVel
+player.friction*dt, 0) --Round to everything below 0, or 0 itself
end
if player.yVel > 0 then
player.yVel = math.max(player.yVel-
player.friction*dt, 0) --Round to everything above 0, or 0 itself
elseif player.yVel < 0 then
player.yVel = math.min(player.yVel
+player.friction*dt, 0) --Round to everything below 0, or 0 itself
end
end
function player.limitSpeed(dt)
if player.xVel > 0 then
player.xVel = math.min(player.xVel,
player.maxSpeed) --Round to everything below maxSpeed, or maxSpeed itself
elseif player.xVel < 0 then
player.xVel = math.min(player.xVel,
player.maxSpeed*- 1) --Round to everything below maxSpeed, or maxSpeed itself
end
if player.yVel > 0 then
player.yVel = math.min(player.yVel,
player.maxSpeed) --Round to everything below maxSpeed, or maxSpeed itself
elseif player.yVel < 0 then
player.yVel = math.min(player.yVel,
player.maxSpeed*- 1) --Round to everything below maxSpeed, or maxSpeed itself
end
end
function player.move (dt)
player.xPos = player.xPos + player.xVel*dt
player.yPos = player.yPos + player.yVel*dt
end
function player.update (dt)
player.checkKeys(dt) --Check all the keys and apply velocity accordingly
player.applyFriction(dt) --Apply friction to the player velocity. ||This code uses a fancy trick, ask me if you want it explained||
player.limitSpeed() --Limits the player speed. ||This code is also quite tricky, again, ask if you want it explained||
player.move(dt) --Apply velocity to the player position
end
function player.draw ()
love.graphics.rectangle( "fill" , player.xPos,
player.yPos, 32, 32 )
end


function love.load()

end

function love.update(dt)
player.update (dt)
end

function love.draw()
player.draw ()
end