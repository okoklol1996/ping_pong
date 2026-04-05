function love.load()
  love.window.setMode(0, 0, {fullscreen=true, resizable=true})
  -- Get the actual phone screen size
  sw = love.graphics.getWidth()
  sh = love.graphics.getHeight()

  love.graphics.setBackgroundColor(135/255, 135/255, 244/255)
  wf = require "libraries/windfield"
  world = wf.newWorld(0, 0)
  
  -- Collision Setup
  world:addCollisionClass('wall_left')
  world:addCollisionClass('wall_right')
  world:addCollisionClass('ground')
  world:addCollisionClass('roof')
  
  player1_score = 0
  player2_score = 0

  -- PADDLES: Positioned based on screen width (sw) and height (sh)
  rectangle1 = world:newRectangleCollider(50, sh/2, 60, 150)
  rectangle2 = world:newRectangleCollider(sw - 50, sh/2, 60, 150)
  
  -- WALLS: Stretched to fit any screen size
  roof = world:newRectangleCollider(sw/2, -10, sw, 20)
  ground = world:newRectangleCollider(sw/2, sh + 10, sw, 20)
  wall_left = world:newRectangleCollider(-10, sh/2, 20, sh)
  wall_right = world:newRectangleCollider(sw + 10, sh/2, 20, sh)
  
  -- BALL: Starts in the exact center
  circle = world:newCircleCollider(sw/2, sh/2, 20)
  
  -- Colors and Types
  rectangles = { rectangle1, rectangle2 }
  rectangles_color = {1, 0, 0}
  circle_color = {1, 1, 0}
  
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
  circle:applyLinearImpulse(-800, -200)
end

function love.touchpressed(id, x, y)
    -- Use sw/2 to split the screen in half for Player 1 and Player 2
    -- Use sh/2 to detect Top vs Bottom touches
    if x < sw/2 then
      if y > sh/2 then rectangle1:setLinearVelocity(0, 400)
      else rectangle1:setLinearVelocity(0, -400) end
    else
      if y > sh/2 then rectangle2:setLinearVelocity(0, 400)
      else rectangle2:setLinearVelocity(0, -400) end
    end
end
