require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
--require "gooi.panel"
require "gooi.layout"
require "gooi.label"
require "gooi.slider"
require "gooi.component"
require "gooi.checkbox"


gamera = require "gamera.gamera"
selectedcolor,bordercolor={0,0,0},{50,50,50}
local palette = love.image.newImageData("palette.png")
local paletteImg = love.graphics.newImage(palette)
local paletteX, paletteY
local paletteWidth, paletteHeight = palette:getWidth(), palette:getHeight()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
c_x,c_y=0,0

function drawPalette()
x,y= cam:toScreen(getGrid(W,H,9,2))
    love.graphics.draw (paletteImg, x, y)
    paletteX, paletteY = x,y
end

function love.load()
gooi.load()
meColor = {0,0,0}
SCale=0.7
cam = gamera.new(0,0,1530,900)
cam:setPosition(0,0)
cam:setScale(SCale)
end



--function love.mousepressed(x, y,btn)
function love.update(dt)
--gooi.update(dt)
x, y = love.mouse.getPosition()
x, y = cam:toWorld(x,y)

    --if paletteX and paletteY and x > paletteX and x < paletteX+paletteHeight and y > paletteY and y < paletteY+paletteWidth then
if paletteX and paletteY and x> paletteX and x< paletteX+ paletteWidth and y> paletteY and y< paletteY+ paletteHeight then
   c_x,c_y=x,y 
     meColor[1], meColor[2], meColor[3] = palette:getPixel((x-paletteX), (y-paletteY))
        --if r < 255 or g < 255 or b < 255 then
            --love.graphics.setBackgroundColor(r, g, b)
        --end
    end
gooi.update(dt)
end

function love.draw()
cam:draw(function()
   drawPalette()
love.graphics.setColor( meColor[1], meColor[2],  meColor[3] ) 
love.graphics.rectangle ("fill", paletteX+paletteWidth+150 , 10, 100, 100)
love.graphics.setColor(bordercolor)
love.graphics.rectangle ("line", paletteX+paletteWidth+150 , 10, 100, 100)

love.graphics.setColor(bordercolor) 
love.graphics.rectangle("line", paletteX, paletteY , paletteWidth, paletteHeight )

love.graphics.circle("line", c_x, c_y, 20)

end)

--love.graphics.print("r  "..r..",g  "..g..",b  "..b,20,100)
love.graphics.print(y,20,100)

getGrid(W,H,9,26)
gooi.draw()
end



function getGrid(x,y,p1,p2)
local sx,sy,xx,yy
sx=30
sy=sx

xx=x/sx
yy=y/sy
for i=1,sx do
for j=1,sy do
--drawGrid(i*xx-(xx),j*yy -(yy) ,xx,yy )
end
end
pos1=p1*xx
pos2=p2*yy
return pos1,pos2
end

function drawGrid(x,y,w,h)
love.graphics.setColor(1,1,1,0.1)
love.graphics.rectangle("line",x,y,w,h)
love.graphics.setColor(1,1,1)
end



function gooi.load()

slidSize = gooi.newSlider({
value = 1,
w = 227 ,
h = 27,
--group = "grp1"
})
slidSize.x, slidSize.y=getGrid(W,H,4,22)


slidOpacity = gooi.newSlider({
value = 1 ,
w = 327,
h = 27,
--group = "grp1"
})
slidOpacity.x, slidOpacity.y=getGrid(W,H,4,26)

buttonPalette=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25
--icon="paintTool.png"
}):setIcon( "imgPalette.png" )
 buttonPalette .x, buttonPalette .y=getGrid(W,H,0,15)


buttonBrush=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25
--icon="paintTool.png"
}):setIcon( "imgBrush.png" )
 buttonBrush .x, buttonBrush.y=getGrid(W,H,0,8)


buttonMenu=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25
--icon="paintTool.png"
}):setIcon( "imgMenu.png" )
 buttonMenu.x, buttonMenu.y=getGrid(W,H,0,1)

end

function love.touchpressed (id, x,
 y) gooi.pressed(id, x, y) end

function love.touchreleased(id, x, y) gooi.
released(id, x, y) end

function love.touchmoved (
id, x, y) gooi.moved(id, x, y)
end
