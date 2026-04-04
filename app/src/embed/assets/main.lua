function love.load()
  wf = require "libraries/windfield"
  
  world = wf.newWorld(0, 0)
  
  world:addCollisionClass('wall_left')
  world:addCollisionClass('wall_right')
  world:addCollisionClass('ground')
  world:addCollisionClass('roof')
  
  player1_score = 0
  player2_score = 0
  rectangle1 = world:newRectangleCollider(0, 300, 100, 200)
  rectangle2 = world:newRectangleCollider(1200, 300, 100, 200)
  roof = world:newRectangleCollider(-30, -30, 3000, 30)
  ground = world:newRectangleCollider(-30, 770, 3000, 30)
  wall_left = world:newRectangleCollider(-40, 0, 30, 3000)
  wall_right = world:newRectangleCollider(1350, 0, 30, 3000)
  circle = world:newCircleCollider(580, 350, 30)
  
  wall_left:setCollisionClass('wall_left')
  wall_right:setCollisionClass('wall_right')
  ground:setCollisionClass('ground')
  roof:setCollisionClass('roof')
  rectangle1:setType('kinematic')
  rectangle2:setType('kinematic')
  roof:setType('static')
  ground:setType('static')
  wall_left:setType('static')
  wall_right:setType('static')
  circle:setRestitution(1)
  circle:applyLinearImpulse(-1000, -250)
end

function love.update(dt)
  world:update(dt)
  if circle:enter('wall_left') then
    circle:destroy()
    player2_score = player2_score + 1
    circle = world:newCircleCollider(580, 350, 30)
    circle:setRestitution(1)
    circle:applyLinearImpulse(1000, 0)
  elseif circle:enter('wall_right') then
    circle:destroy()
    player1_score = player1_score + 1
    circle = world:newCircleCollider(580, 350, 30)
    circle:setRestitution(1)
    circle:applyLinearImpulse(-1000, 0)
end
   p1x, p1y = rectangle1:getPosition()
   p2x, p2y = rectangle2:getPosition()
   if p1y < 100 then
     rectangle1:setY(100)
     rectangle1:setLinearVelocity(0, 0)
   elseif p1y > 670 then
     rectangle1:setY(670)
     rectangle1:setLinearVelocity(0, 0)
   end
   if p2y < 100 then
     rectangle2:setY(100)
     rectangle2:setLinearVelocity(0, 0)
   elseif p2y > 670 then
     rectangle2:setY(670)
     rectangle2:setLinearVelocity(0, 0)
end
end

function love.touchpressed(id, x, y)
    if y > 400 and x < 800 then
      rectangle1:setLinearVelocity(0, 100)
    elseif y < 400 and x < 800 then
      rectangle1:setLinearVelocity(0, -100)
    elseif y > 400 and x > 800 then
      rectangle2:setLinearVelocity(0, 100)
    elseif y < 400 and x > 800 then
      rectangle2:setLinearVelocity(0, -100)
    end
end

function love.draw()
  love.graphics.print(player1_score, 500, 30, 0, 1.5)
  love.graphics.print(player2_score, 700, 30, 0, 1.5)
  world:draw()
end
