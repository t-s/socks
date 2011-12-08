require ('math') -- for sin and cos
hc = require 'hardoncollider' -- collision detection library
require('classlib') -- for oo

xoffset = 0
yoffset = 0
x2offset = 195
y2offset = 0
text = {}
players1 = {}
players2 = {}
nextInstantaneousTime = 0
Player = class()
field = love.graphics.newImage("images/field.bmp");
player = love.graphics.newImage("images/footy.png");
ball = love.graphics.newImage("images/ball.png");

worldWidth = field:getWidth()
worldHeight = field:getHeight()

ballx = worldWidth/2 
bally = worldHeight/2 - (ball:getHeight()/2)

for i = 0, 10 do

	players1[i] = Player('white')

end

for i = 0, 10 do

	players2[i] = Player('red')

end

-- hc.addRectangle() -- for each player
-- hc.addCircle() -- for ball

function love.load()

	hardoncollider.init(150, on_collide)
	
	--draw screen
	love.graphics.setMode(worldWidth, worldHeight, false, true, 2)

end


function love.draw()


	worldWidth = field:getWidth()
	worldHeight = field:getHeight()
	
	love.graphics.draw(field,0,0)
	
	--first argument is x offset, second is y offset
	--third argument is width, fourth is height
	--fifth and sixth are unknown? scaling?
	playerQuad = love.graphics.newQuad(xoffset, 0, 14, 11, 300, 150)
	player2Quad = love.graphics.newQuad(x2offset, 0, 12, 11, 300, 150)
	
	
	
	
	
	love.graphics.drawq(player, playerQuad, 20, 300, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 100, 150, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 100, 250, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 100, 350, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 100, 450, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 300, 200, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 300, 300, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 300, 400, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 500, 150, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 500, 250, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 500, 350, 0, 2, 2)
	love.graphics.drawq(player, playerQuad, 500, 450, 0, 2, 2)
	
	love.graphics.drawq(player, player2Quad, 1080, 300, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 1000, 150, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 1000, 250, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 1000, 350, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 1000, 450, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 800, 200, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 800, 300, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 800, 400, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 600, 150, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 600, 250, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 600, 350, 0, 2, 2)
	love.graphics.drawq(player, player2Quad, 600, 450, 0, 2, 2)
	
	love.graphics.draw(ball,ballx,bally)
	
	for i = 1,#text do
        love.graphics.setColor(255,255,255, 255)
		love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end
	

end


function love.update(dt)

	cTime = love.timer.getTime()
	instantaneousTime = math.floor(cTime*4)
	
	if(instantaneousTime > nextInstantaneousTime) then
		nextInstantaneousTime = math.floor(cTime*4)
		xoffset = xoffset + 15
		x2offset = x2offset  + 15
	end
	
	if(xoffset > 75) then
		xoffset = 45
	end
	
	if(x2offset > 225) then
		x2offset = 195 
	end
	
	yoffset = yoffset + 10

	if love.keyboard.isDown("q") then
		os.exit()
	end
	
end

function Player:__init(team,x,y)

	self.team = team
	self.x = x
	self.y = y
	self.xOffset = xOffset
	self.yOffset = yOffset

end

function on_collide(dt, shape1, shape2, mtv_x, mtv_y)

end

