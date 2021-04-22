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
sock = require "sock.sock"
bitser = require "sock.spec.bitser"



function drawPalette()
local x,y
x,y= cam2:toScreen(getGrid(W,H,9,2))
    love.graphics.draw (paletteImg, x, y)
    paletteX, paletteY = x,y
end


--initialization (pre-function)
local imgSplash         -- displays a splash on current draw of screen touch.
local tblSplash = {}    -- splash(frames)
local splashActFPS      -- splash(active frame)
local splashCurrFPS = 1 -- splash(current frame)
local elapsedTime = 0   -- current elapsed time for sprite loop
local drag = false
local tapx, tapy,tapx2,tapy2 xx, yy = 0, 0, 0, 0, 0, 0
local scrollSpeed=0.07--0.09
local lastX,lastY = 0,0

function love.load()
selectedcolor,bordercolor={0,0,0},{50,50,50}
paletteNumber=1
paletteImg = {}
	--for k, v in pairs ( { "raise", "lower", "next", "previous", "newlayer", "newgroup", "newshape", "cyclegroup", "cycleshape", "delete" } ) do
		for i=1,6 do
paletteImg[i] = love.image.newImageData ( "palette" .. i .. ".png" )
	end

palette =paletteImg[4] --love.image.newImageData("pallet.png")
paletteImg = love.graphics.newImage(palette)
--paletteX, paletteY
 paletteWidth, paletteHeight = palette:getWidth(), palette:getHeight()
W, H = love.graphics.getWidth(),
love.graphics.getHeight()
c_x,c_y=0,0


showPaletteMenu=false

meColor = {0,0,0}
meColorR,meColorG,meColorB=0,0,0

SCale2=0.7
cam2= gamera.new(0,0,1530,900)
cam2:setPosition(0,0)
cam2:setScale(SCale2)

taptapTrue=false
doubleTap={}
Screentouches = love.touch.getTouches()

posX,posY=0,0
shit={}
shit.angle=0
secondX,secondY=0,0
secondRel={}
secondSta={}
SCale=1
			newlines={}
			active=true
			lines={}
			SCale=1
			--cam = gamera.new(0,0,2130,1460)
			cam = gamera.new(0,0,2130,1460)
			W, H = love.graphics.getWidth(),love.graphics.getHeight()
			gooi.load()

bound={
x=0,
y=H-60,
w=W, 
h=H-60
}

    	-- how often an update is sent out
   	 	tickRate = 1/60
    	tick = 0
  	  --client = sock.newClient("localhost", 22122)
  		client = sock.newClient("192.168.43.45",12345)
 		 	--client = sock.newClient("192.168.43.10",22122)
			--client = sock.newClient("192.168.43.39", 22122)
    	client:setSerialization(bitser.dumps, bitser.loads)
    	client:setSchema("playerState", {
      		 	 "index",
    		  	  --"player",
      		  	"drawn",
  	  })
    	-- store the client's index
  	  -- playerNumber is nil otherwise
    	client:on("brushNum", function(num)
      			  brushNumber = num
  	  end)
  		-- client:on("beenDraw", function(num)
    	 --  draw[index].brush = num
   		-- end)


			if brushNumber == nil then
							brushNumber=1
			end


   	 	-- receive info on where the players are located
   		 client:on("playerState", function(data)
      			  local index = data.index
      			  local drawn = data.drawn
     	 			  -- only accept updates for the other player
       				 if brushNumber and index ~= brushNumber then
            					--draw[index] = drawn
            				  table.insert(draw[index].brush, drawn)
        				end
  	  end)
    	client:connect()
   		 function newBrush(x, y)
       			 return {
            x = x,
            y = y,
            w = 20,
            h = 100,
            brush={}, 
        }
   		 end

				local marginX = 50
   			 draw = {
       				 newBrush(marginX, love.graphics.getHeight()/2),
        				newBrush(love.graphics.getWidth() - marginX, love.graphics.getHeight()/2)
  			  }
 				 --love.graphics.setLineStyle('rough')
  				love.graphics.setLineStyle('smooth')
  				theCanvas = love.graphics.newCanvas(800,600)
  				WeDrawCanvas = love.graphics.newCanvas(1800,1600)
					cam:setPosition(0,0)
--gooi.setGroupEnabled("grp2",false)
--gooi.setGroupVisible("grp2",false)
end




function love.update(dt)
				gooi.update(dt)
  			client:update()
 			 --if client:getState() == "connected" then
				if client:getState() == "connected" or client:getState() == "connecting" or client:getState() == "disconnected" then
      					 tick = tick + dt
      					 -- simulate the ball locally, and receive corrections from the server
      					 --ball.x = ball.x + ball.vx * dt
       						--ball.y = ball.y + ball.vy * dt
 			 end
 			 --if tick >= tickRate then
 			 tick = 0
 			 if brushNumber then
 					   Screentouches = love.touch.getTouches()
							--insert my cool converter function goes here 😎 
							ll=slid:getValue()*2--1.8
							SCale=ll
							--SCale=math.max(SCale, 0.3)
							if len then 
											--SCale=len*0.002
											--SCale=math.max(SCale, 0.3)
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
							if love.mouse.isDown(1) and active and taptapTrue and #Screentouches <= 1 and showPaletteMenu== false then
    									local newX,newY = love.mouse.getPosition()
											newX,newY=cam:toWorld(newX,newY)
   			 							love.graphics.setCanvas(theCanvas)
											love.graphics.setLineWidth(5)
 			   							love.graphics.line(lastX,lastY,newX,newY)
    									love.graphics.setCanvas()
  									  --myColor=meColor
  	 									 myWidth=slidSize:getValue()*60
											--table.insert(lines, {lastX, lastY,newX, newY, stop, myColor, myWidth})
											table.insert(draw[brushNumber].brush	, {lastX=lastX,lastY=lastY,newX=newX, newY=newY, stop=stop,
											meColorR=meColorR,meColorG=meColorG,meColorB=meColorB,myWidth=myWidth})
  		  						 	 client:send("mouseY", {lastX=lastX,lastY= lastY,newX=newX,newY= newY,stop= stop, meColorR=meColorR,meColorG=meColorG,meColorB=meColorB, myWidth=myWidth} )
  	 									 lastX,lastY = newX,newY
 							 end
          	  --client:send("beenDraw",draw[brushNumber].brush )
if showPaletteMenu then
							updatePaletteMenu()
end
				end
				--end

end


function love.mousereleased(x,y,button)
 		 if button == 1 and active and taptapTrue and #Screentouches <= 1 and showPaletteMenu== false then
    				stop=true
						--table.insert(lines[#lines],5, stop)
						--table.insert(draw[brushNumber].brush[#draw[brushNumber].brush]	,5, stop)
						--table.insert(draw[brushNumber].brush[#draw[brushNumber].brush]	,5, stop)
						draw[brushNumber].brush[#draw[brushNumber].brush].stop= stop
						--vip[5]= stop
						--#draw[brushNumber].brush
			 end
end


function love.mousepressed(x,y,button)
		 if clickButton(x,y,button,slid) then
						active=false
						else active=true
			end 
  		if button == 1 then
   					 lastX,lastY = cam:toWorld(x,y)--x/SCale,y/SCale

							stop=false
 			 end
				table.insert(doubleTap,love.timer.getTime())
end


function updatePaletteMenu()
--gooi.update(dt)
local x,y
x, y = love.mouse.getPosition()
x, y = cam2:toWorld(x,y)

    --if paletteX and paletteY and x > paletteX and x < paletteX+paletteHeight and y > paletteY and y < paletteY+paletteWidth then
if paletteX and paletteY and x> paletteX and x< paletteX+ paletteWidth and y> paletteY and y< paletteY+ paletteHeight then
   c_x,c_y=x,y 
     meColorR, meColorG, meColorB = palette:getPixel((x-paletteX), (y-paletteY))
        --if r < 255 or g < 255 or b < 255 then
            --love.graphics.setBackgroundColor(r, g, b)
        --end
    end
end


function drawPaletteMenu(c)
if showPaletteMenu then
cam2:draw(function()
love.graphics.setColor(1,1,1)
   drawPalette()
love.graphics.setColor( meColorR, meColorG,  meColorB) 
love.graphics.rectangle ("fill", paletteX+paletteWidth+150 , 10, 100, 100)
love.graphics.setColor(bordercolor)
love.graphics.rectangle ("line", paletteX+paletteWidth+150 , 10, 100, 100)

love.graphics.setColor(bordercolor) 
love.graphics.rectangle("line", paletteX, paletteY , paletteWidth, paletteHeight )

love.graphics.circle("line", c_x, c_y, 20)

end)
gooi. draw ("grp2" )
getGrid(W,H,9,26)
end
gooi.setGroupVisible("grp2",showPaletteMenu)
gooi.setGroupEnabled("grp2",showPaletteMenu)

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



function shallowcopy(orig)
		local orig_type = type (orig)
		local copy
		if orig_type == 'table' then
						copy = {}
						for orig_key, orig_value in pairs(orig) do
										copy[orig_key] = orig_value
						end
						else -- number, string, boolean, etc
										copy = orig
		end
		return copy
end


function table.clone (org)
			return { table.unpack (org)}
end


function love.draw()
		love.graphics.print("scale:    "..SCale,20,20)
		love.graphics.print("ll:    "..ll,20,30)

		cam:draw(function()
					--love.graphics.draw(theCanvas)
					love.graphics.setColor(1,1,0)
					love.graphics.setLineWidth(10)
 				 	--love.graphics.setLineStyle('rough') 
					--drawem()
					love.graphics.setLineWidth(5)
					love.graphics.setColor(1,1,1)
					love.graphics.setColor(1,0,0)
					love.graphics.setLineWidth(3)
					drawem2()
					love.graphics.setLineWidth(5)
					love.graphics.setColor(1,1,1)
					--love.graphics.draw(theCanvas)
					--[[
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
					end ]]
   				for i, id in ipairs(Screentouches) do
       						local tchx,tchy = love.touch.getPosition(id)--do
									tchx,tchy=cam:toWorld(tchx,tchy)
       						love.graphics.circle("line",tchx,tchy, 19)
        					--love.graphics.draw(imgSplash,splashActFPS,tchx,tchy,0,3,3,16,16)
    			end

					--end
					if movex then
									love.graphics.rectangle("line",movex,movey,30,30)
					end
		end)
		
		drawBound(bound)
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
gooi.draw()

gooi.draw("grp1")
gooi.setGroupVisible("grp1",not showPaletteMenu)
gooi.setGroupEnabled("grp1",not showPaletteMenu)


if taptapTrue==true then
--buttonBrush:setIcon( "imgBrush.png" )
else
--buttonBrush:setIcon( "imgMenu.png" )
end
if showPaletteMenu then
love.graphics.setColor(0,0,0,0.6)
love.graphics.rectangle("fill",0,0,W,H)
end
drawPaletteMenu(showPaletteMenu) 


end


function useless(a, b, a2,b2)
		return (a+a2)/2,(b+b2)/2
end

function drawem()
		for i, self in pairs(lines) do
					love.graphics.line(self[1],self[2],self[3],self[4])
		end
end


function drawem2()
			--for h, v in pairs (draw) do
			for h=1,#draw-1 do
local v=draw[h]
						--for i, b in pairs (draw[h].brush) do
						for i=1,#draw[h].brush,1 do
local b=draw[h].brush[i]
									--if b[6]~= nil then

												love.graphics.push()
												love.graphics.setColor(b.meColorR,b.meColorG,b.meColorB)
												love.graphics.setLineWidth(b.myWidth)
									--end
									love.graphics.line( b.lastX, b.lastY,b.newX,b.newY)
									--love.graphics.line(draw[1].brush[i][1],draw[1].brush[i][2], draw[1].brush[i][3], draw[1].brush[i][4])
									--love.graphics.line(math. floor(draw[1].brush[i][1]),
									--math. floor(draw[1].brush[i][2]),math. floor( draw[1].brush[i][3]),math. floor( draw[1].brush[i][4]))
												love.graphics.pop()
									love.graphics.setLineWidth(1)
									love.graphics.setColor(1,1,1)

						end	
			end
			for i, b in pairs (draw) do
						if b[1] then
									local v=b[1][1]
									love.graphics.line(b[1][1][1], b[1][1][2], v[3], v[4])
						end
			end
end


function clickButton(mx,my,button,btn)
			if button == 1
			and mx >= btn.x and mx < btn.x + btn.w
			and my >= btn.y and my < btn.y + btn.h then
						-- stuff to do when your image has been clicked
						return true end
			end


function drawBound(self)
			love.graphics.print("lines  ".. tostring(#lines), 130,10)
			love.graphics.print("draw/players  ".. tostring(#draw), 130,20)
			love.graphics.print("brush for player  ".. tostring(#draw[brushNumber].brush), 130,30)
			love.graphics.print("FPS: "   ..love.timer.getFPS(), 130,40)
			love.graphics.print("showPaletteMenu: "   ..tostring(showPaletteMenu), 130,50)
			love.graphics.print(tostring(stop), 190,10)
			love.graphics.print("taptapTrue  "..tostring(taptapTrue), 130,80)

			--if draw[1].draw then
			for i, b in pairs (draw[brushNumber].brush) do
									--love.graphics.print(tostring(b[1][1][1]), 260,10*i)
									--love.graphics.print(tostring(b[1][1][1]), 300,10*j)
									--love.graphics.print(tostring(draw[brushNumber].brush[i][6]), 300,10*i)

									--love.graphics.print(tostring(b.meColorR), 300,10*i)

									--end
			end
			for i, b in pairs (doubleTap) do
									--love.graphics.print(tostring(b), 60,10*i)
			end
			--for u=#doubleTap-1,#doubleTap
			if doubleTap[#doubleTap-1] then
								local taptap= doubleTap[#doubleTap]-doubleTap[#doubleTap-1]
								love.graphics.print("taptap  "..taptap, 130,60)
								if taptap<=0.179 then
													taptapTrue=not taptapTrue
													doubleTap={}
								end
			end
			--end
			love.graphics.rectangle("line", self.x, self.y,self.w, self. h)
end


function gooi:load()
slid = gooi.newSlider({
value = 0.9 ,
x = 177 ,
y = 254 ,
w = 207 ,
h = 27,
group = "grp1"
})

slidSize = gooi.newSlider({
value = 1,
w = 380 ,
h = 27,
group = "grp2"
})
slidSize.x, slidSize.y=getGrid(W,H,4,23)


slidOpacity = gooi.newSlider({
value = 1 ,
w = 327,
h = 27,
group = "grp2"
});slidOpacity.x, slidOpacity.y=getGrid(W,H,4,26)

buttonPalette=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25
--icon="paintTool.png"
}):setIcon( "imgPalette.png" ): onRelease(function()showPaletteMenu=not showPaletteMenu end)
buttonPalette .x, buttonPalette .y=getGrid(W,H,0,15)


buttonBrush=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25
--icon="paintTool.png"
}): onRelease(function()taptapTrue= not taptapTrue end)
buttonBrush .x, buttonBrush.y=getGrid(W,H,0,8)


buttonMenu=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25
--icon="paintTool.png"
}):setIcon( "imgMenu.png" );buttonMenu.x, buttonMenu.y=getGrid(W,H,0,1)


buttonNextPalette=gooi.newButton({
text="",
w=50,
h=50,
sx=0.25,
sy=0.25,
group = "grp2"
--icon="paintTool.png"
}):setIcon( "imgNextPalette.png" )
 buttonNextPalette.x, buttonNextPalette.y=getGrid(W,H,17,1)

end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "home" then
        love.event.quit()
    end
end


function love.touchpressed (id, x,y)
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
end

function love.touchreleased(id, x, y)
			gooi.released(id, x, y) 
table.insert(secondRel,{secondX,secondY})
	tapRelx = x
	tapRely = y
	drag = false
if taptapTrue==fslse then--#Screentouches >= 2 then
--movex,movey=posX+(tapx-tapx2)*scrollSpeed,posY+(tapy-tapy2)*scrollSpeed
--cam:setPosition(math.floor(movex),math.floor(movey))
--cam:setPosition(posX,posY)

end
end

function love.touchmoved (id, x, y) 
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
	if taptapTrue==false and showPaletteMenu ==false then--#Screentouches >= 2 then
		movex,movey=posX+(calkX)*scrollSpeed,posY+(calkY)*scrollSpeed
		cam:setPosition(math.floor(movex),math.floor(movey))
	end
end




