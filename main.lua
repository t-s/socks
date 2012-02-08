require ('math') -- for sin and cos
hc = require 'hardoncollider' -- collision detection library
require('classlib') -- for oo

function on_collide(dt, shape1, shape2, mtv_x, mtv_y)

	-- white is players1
	-- red is players2
	
	if (shape1.team == 'ball' or shape2.team == 'ball') then
		text[#text+1] = "ball"
		if(shape1.team == 'ball') then
			ballx = ballx - mtv_x/2;
			bally = bally - mtv_y/2;
			ballBox:moveTo(ballx,bally)
		end
		
		if(shape2.team == 'ball') then
			ballx = ballx - mtv_x/2;
			bally = bally - mtv_y/2;
			ballBox:moveTo(ballx,bally)
		end
	
	else
	
		if (shape1.team == 'white' and shape2.team == 'red') then --shape1 is in players1
			text[#text+1] = "first"
			players1[shape1.id].x = players1[shape1.id].x + mtv_x/2;
			players1[shape1.id].y = players1[shape1.id].y + mtv_y/2;
			
			shape1:moveTo(players1[shape1.id].x,players1[shape1.id].y)
			
			players2[shape2.id].x = players2[shape2.id].x - mtv_x/2;
			players2[shape2.id].y = players2[shape2.id].y - mtv_y/2;
			
			shape2:moveTo(players2[shape2.id].x,players2[shape2.id].y)
		end
	
		if  (shape1.team == 'red' and shape2.team == 'white') then --shape1 is in players2
			text[#text+1] = "second"
			players2[shape1.id].x = players2[shape1.id].x + mtv_x/2;
			players2[shape1.id].y = players2[shape1.id].y + mtv_y/2;
			
			shape1:moveTo(players2[shape1.id].x,players2[shape1.id].y)
			
			players1[shape2.id].x = players1[shape2.id].x - mtv_x/2;
			players1[shape2.id].y = players1[shape2.id].y - mtv_y/2;
			
			shape2:moveTo(players1[shape2.id].x,players1[shape2.id].y)
		end
		
		if (shape1.team == 'white' and shape2.team == 'white') then --shape1 is in players1
			text[#text+1] = "white"
			players1[shape1.id].x = players1[shape1.id].x + mtv_x/2;
			players1[shape1.id].y = players1[shape1.id].y + mtv_y/2;
			
			shape1:moveTo(players1[shape1.id].x,players1[shape1.id].y)
			
			players1[shape2.id].x = players1[shape2.id].x - mtv_x/2;
			players1[shape2.id].y = players1[shape2.id].y - mtv_y/2;
			
			shape2:moveTo(players1[shape2.id].x,players1[shape2.id].y)
		end
		
		if (shape1.team == 'red' and shape2.team == 'red') then --shape1 is in players1
			text[#text+1] = "red"
			players2[shape1.id].x = players2[shape1.id].x + mtv_x/2;
			players2[shape1.id].y = players2[shape1.id].y + mtv_y/2;
			
			shape1:moveTo(players2[shape1.id].x,players2[shape1.id].y)
			
			players2[shape2.id].x = players2[shape2.id].x - mtv_x/2;
			players2[shape2.id].y = players2[shape2.id].y - mtv_y/2;
			
			shape2:moveTo(players2[shape2.id].x,players2[shape2.id].y)
		end
	end
end

xoffset = 0
yoffset = 0
x2offset = 195
y2offset = 0
text = {}
players1 = {}
players2 = {}
nextInstantaneousTime = 0
Player = class()
Position = class()
field = love.graphics.newImage("images/field.bmp");
playerSprite = love.graphics.newImage("images/footy.png");
ball = love.graphics.newImage("images/ball.png");
start = true

worldWidth = field:getWidth()
worldHeight = field:getHeight()

ballx = worldWidth/2 - (ball:getWidth()/2) -- + 1
bally = worldHeight/2 - (ball:getHeight()/2)

playerPositions1x = {}
playerPositions1y = {}
playerPositions2x = {}
playerPositions2y = {}

playerPositions1x[0] = 30;   playerPositions2x[0] = 1170;
playerPositions1y[0] = 350;  playerPositions2y[0] = 350;

playerPositions1x[1] = 150;  playerPositions2x[1] =  1050;
playerPositions1y[1] = 200;  playerPositions2y[1] =  200;
playerPositions1x[2] = 150;  playerPositions2x[2] =  1050;
playerPositions1y[2] = 350;  playerPositions2y[2] =  350;
playerPositions1x[3] = 150;  playerPositions2x[3] =  1050;
playerPositions1y[3] = 500;  playerPositions2y[3] =  500;

playerPositions1x[4] = 350;  playerPositions2x[4] =  850;
playerPositions1y[4] = 150;  playerPositions2y[4] =  150;
playerPositions1x[5] = 350;  playerPositions2x[5] =  850;
playerPositions1y[5] = 275;  playerPositions2y[5] =  275;
playerPositions1x[6] = 350;  playerPositions2x[6] =  850;
playerPositions1y[6] = 400;  playerPositions2y[6] =  400;
playerPositions1x[7] = 350;  playerPositions2x[7] =  850;
playerPositions1y[7] = 550;  playerPositions2y[7] =  550;

playerPositions1x[8] = 550;  playerPositions2x[8] =  650;
playerPositions1y[8] = 225;  playerPositions2y[8] =  225;
playerPositions1x[9] = 550;  playerPositions2x[9] =  650;
playerPositions1y[9] = 350;  playerPositions2y[9] =  350;
playerPositions1x[10] = 550; playerPositions2x[10] = 650;
playerPositions1y[10] = 475; playerPositions2y[10] = 475;


function love.load()

	hardoncollider.init(10000, on_collide)
	
	--draw screen
	love.graphics.setMode(worldWidth, worldHeight, false, true, 2)

	for i = 0, 10 do
		players1[i] = Player('white')
		players1[i].x = (50*i)+50;
		players1[i].y = 100;
		players1[i].height = -10
		players1[i].width = -10
		players1[i].box = hc.addRectangle(players1[i].x+10,players1[i].y+10,20,20)
		players1[i].box.id = i
		players1[i].box.team = 'white'
	end

	for i = 0, 10 do
		players2[i] = Player('red')
		players2[i].x = (50*(i+10))+130; --130 is a magic number that looks good
		players2[i].y = 100;
		players2[i].height = -10
		players2[i].width = -10
		players2[i].box = hc.addRectangle(players2[i].x+10,players2[i].y+10,20,20)
		players2[i].box.id = i
		players2[i].box.team = 'red'
	end

	--ballBox = hc.addCircle(ballx,bally, 5)
	ballBox = hc.addRectangle(ballx,bally,ball:getWidth(),ball:getHeight())
	ballBox.team = 'ball'
	ballBox.id = 11
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
	
	for i = 0, 10 do
		love.graphics.drawq(playerSprite, playerQuad,players1[i].x,players1[i].y,0,2,2)
	end
	
	for i = 0, 10 do
		love.graphics.drawq(playerSprite, player2Quad, players2[i].x,players2[i].y,0,2,2)
	end
	
	love.graphics.draw(ball,ballx,bally)
	
	for i = 1,#text do
        love.graphics.setColor(255,255,255, 255)
		love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end
    
    for i = 0, 10 do
		--players1[i].box:draw()
		--players2[i].box:draw()
	end

	ballBox:draw()

end


function love.update(dt)

	--text[#text+1] = cTime
	hc.update(dt)
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
	
	if love.keyboard.isDown("s") then
		dt = dt - 100
	end
	
	for i = 0, 10 do
		players1[i].box:moveTo(players1[i].x+10,players1[i].y+10)
		players2[i].box:moveTo(players2[i].x+10,players2[i].y+10)
	end

	
	if start == true then
		for i = 0, 10 do
			players1[i]:moveTo(playerPositions1x[i]+players1[i].width, playerPositions1y[i]+players1[i].height)
		end
		for j = 0, 10 do
			players2[j]:moveTo(playerPositions2x[j]+players2[j].width, playerPositions2y[j]+players2[j].height)
		end
	end
	
	if cTime > 7.5 then
		start = false
	end
	
	if start == false then
		for i = 10, 10 do
			players1[i]:moveTo(ballx,bally)
			--players2[i]:moveTo(ballx,bally)
		end
	end
	
	while #text > 10 do
		table.remove(text, 1)
	end

end

function Player:__init(team,x,y)

	--should put player size (of quad)

	self.team = team
	self.x = x
	self.y = y
	self.xOffset = xOffset
	self.yOffset = yOffset
	self.height = -20 -- minus 20 looks good?
	self.width = -10

end

function Player:moveTo(newx,newy)
	
	xMV = newx - self.x
    yMV = newy - self.y
  
    distance = math.sqrt(xMV^2 + yMV^2)
 
    xUnitVector = (xMV/distance)
    yUnitVector = (yMV/distance)
  
    xMovementVector = xUnitVector * 1.5
    yMovementVector = yUnitVector * 1.5
  
    self.x = self.x + xMovementVector
 	self.y = self.y + yMovementVector
	
end

function Position:__init(x,y)
	self.x = x
	self.y = y
end
