--// Resources
Renderer = require("src.graphics.renderer")
Sprite = require("src.graphics.objects.sprite")

--// LOVE LOAD
function love.load()
    
    renderer = Renderer.new()
    renderer:addFrame("main")

    f = renderer:getFrame("main")
    cam = f:getCamera()

    obj = Sprite.new("assets/images/pacman.png")
    obj.position.x = 50
    obj.position.y = 50
end

--// LOVE UPDATE
function love.update(dt)
   obj.rotation = obj.rotation + 0.5 * dt
end 

--// LOVE DRAW
function love.draw()
    renderer:addObject("main", obj)
    renderer:draw()
end

function love.keypressed(key)

    if key == "up" then
        cam.position.y = cam.position.y - 10
    elseif key == "down" then
        cam.position.y = cam.position.y + 10
    elseif key == "left" then
        cam.position.x = cam.position.x - 10
    elseif key == "right" then
        cam.position.x = cam.position.x + 10
    end

    if key == "kp+" then
        cam.zoom = cam.zoom + 0.1
        elseif key == "kp-" then
        cam.zoom = cam.zoom - 0.1
    end
    --print(key)
end