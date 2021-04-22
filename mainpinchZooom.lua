gamera = require "gamera.gamera"
require "gooi.gooi"
require "gooi.button"
--require "gooi.joy"
require "gooi.panel"
require "gooi.slider"
require "gooi.layout"
require "gooi.label"
--require "gooi.spinner"
require "gooi.component"
require "gooi.checkbox"
local ffi = require ( "ffi" )
local utf = require ( "utf8" )
local mt = require ( "multitouch" )()
--local Multitouch = require ( "multitouch" )

--initialization (pre-function)
local imgSplash         -- displays a splash on current draw of screen touch.
local tblSplash = {}    -- splash(frames)
local splashActFPS      -- splash(active frame)
local splashCurrFPS = 1 -- splash(current frame)
local elapsedTime = 0   -- current elapsed time for sprite loop
local drag = false
local tapx, tapy,tapx2,tapy2 xx, yy = 0, 0, 0, 0, 0, 0
local scrollSpeed=0.07--0.09

function love.load()
Screentouches = love.touch.getTouches()
posX,posY=0,0
shit={}
shit.angle=0
secondX,secondY=0,0
secondRel={}
secondSta={}
testImage=love.graphics.newImage ( "testImage.png" )
SCale=1
--cam = gamera.new(0,0,2130,1460)
cam = gamera.new(0,0,3130,2460)
W, H = love.graphics.getWidth(),
love.graphics.getHeight()
gooi.load()
end



function love.update(dt)
    Screentouches = love.touch.getTouches()
gooi.update(dt)
ll=slid:getValue() 
SCale=ll
if len then 
--SCale=len*0.002
SCale=math.max(SCale, 0.3)
end

if tapx and drag and tapx2 then
--cam:setPosition(secondX,secondY)
end
posX,posY=cam:getPosition()

if #Screentouches <= 1 and movex then
cam:setPosition(movex,movey)
else
--cam:setPosition(posX,posY)
end
cam:setScale(SCale)
end

function useless(a, b, a2,b2)
return (a+a2)/2,(b+b2)/2
end


function 	draw1()
	if wedo then
		for i=1,10 do
    		love.graphics.rectangle ("line",
				math. random (500),
				math. random (700),
				math. random (100),
				math. random (200)
			)
		end
	end
end


function love.draw()
love.graphics.print("Android Touch Splash 1.0",0,0)
cam:draw(function()
	love.graphics.draw(testImage,0,0)--,math.rad(shit.angle))
    --Screentouches = love.touch.getTouches()
if #Screentouches >= 2 then
--love.graphics.print("touch.  ".. mt. touch[2].present[2],0,30)
 local tchx,tchy = love.touch.getPosition(Screentouches[1])
 local tchx2,tchy2 = love.touch.getPosition(Screentouches[2])
tchx,tchy=cam:toWorld(tchx,tchy)
tchx2,tchy2=cam:toWorld(tchx2,tchy2)

local dx =tchx2-tchx
local dy=tchy2-tchy
 len = math. sqrt(dx*dx+dy*dy)
local angle=math. atan2(dy, dx)
--angle=math.deg(angle)
secondX, secondY=useless(tchx,tchy, tchx2,tchy2)
  love.graphics.line(tchx,tchy,tchx2,tchy2)
  love.graphics.circle("line",secondX,secondY,10)
  
shit={
tchx=tchx,
tchy =tchy, 
tchx2=tchx2,
tchy2 =tchy2,

dx=dx, 
dy=dy, 
len=len, 
--angle=angle, --math. deg(angle), 
angle=math. deg(angle), 

secondX=secondX, 
secondY=secondY
}

end
    for i, id in ipairs(Screentouches) do
       local tchx,tchy = love.touch.getPosition(id)do
        tchx,tchy =  tchx/SCale,tchy/SCale
       love.graphics.circle("line",tchx,tchy, 19)

        --love.graphics.draw(imgSplash,splashActFPS,tchx,tchy,0,3,3,16,16)
    end

end
if movex then
	love.graphics.rectangle("line",movex,movey,30,30)
end
end)

local j=1
for i, v in pairs (shit) do
 local jjb,jjj = cam:toWorld(W-280,15)
 love.graphics.print(i .. ":   " ..v ,W-190,15*j)
j=j+1
end

if slid:overIt() then
love.graphics.print("weeeeeeeeeeeee.  ".. #Screentouches,10,30)
end
 love.graphics.print("touch.  ".. #Screentouches,0,10)
--love.graphics.print("tapx, tapy, drag.  ".. tapx.. ", ".. tapy.. ",  ".. tostring(drag),0,20)

gooi. draw()
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "home" then
        love.event.quit()
    end
end




function gooi:load()
slid = gooi.newSlider({
value = 0.9 ,
x = 177 ,
y = 254 ,
w = 207 ,
h = 27,
--group = "grp1"
})
end


function love.touchpressed (id, x,y, dx, dy, p )
gooi.pressed(id, x, y)
table.insert(secondSta,{secondX,secondY})

if #Screentouches >= 2 then


	--tapx = secondX
	--tapy = secondY
end
	--tapx,tapy= secondSta[#secondSta]
	tapx = x
	tapy = y

	drag = true
		mt:touchpressed ( id, x, y, dx, dy, p )

 end

function love.touchreleased(id, x, y, dx, dy, p )
gooi.released(id, x, y)
table.insert(secondRel,{secondX,secondY})
	tapRelx = x
	tapRely = y
	drag = false
if #Screentouches >= 2 then
--movex,movey=posX+(tapx-tapx2)*scrollSpeed,posY+(tapy-tapy2)*scrollSpeed
--cam:setPosition(math.floor(movex),math.floor(movey))
--cam:setPosition(posX,posY)

end
end

function love.touchmoved (id, x, y, dx, dy, p ) 
gooi.moved(id, x, y)
	tapx2 = x
	tapy2 = y
calkX,calkY=tapx-tapx2,tapy-tapy2
	if posX >= calkX and posY >= calkY then
		ex=true
		cam:setPosition(posX,posY)
	else
		ex=false
	end
	if #Screentouches >= 2 then
		movex,movey=posX+(calkX)*scrollSpeed,posY+(calkY)*scrollSpeed
		cam:setPosition(math.floor(movex),math.floor(movey))
	end
end





