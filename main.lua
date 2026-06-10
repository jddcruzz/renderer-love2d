--// Resources
Renderer = require("src.graphics.renderer")
Sprite = require("src.graphics.objects.sprite")

--// LOVE LOAD
function love.load()
    
    renderer = Renderer.new()

    mainFrame = renderer:addFrame("main", true)
    mainCam = mainFrame:getCamera()

    obj = Sprite.new("assets/images/pacman.png")
    obj.position.x = 50
    obj.position.y = 25

    local frameConfig = {
        position = {x = 100, y = 25},
        size = {w = 250, h = 50},
        zIndex = 10
    }
    uiFrame = renderer:addFrame("ui", false, frameConfig)
    uiCam = uiFrame:getCamera()

end

--// LOVE UPDATE
function love.update(dt)
   obj.rotation = obj.rotation + 0.5 * dt
end 

--// LOVE DRAW
function love.draw()
    renderer:addObject("main", obj)
    renderer:addObject("ui", obj)
    renderer:draw()
end

function love.keypressed(key)

    if key == "up" then
        mainCam.position.y = mainCam.position.y - 10
    elseif key == "down" then
        mainCam.position.y = mainCam.position.y + 10
    elseif key == "left" then
        mainCam.position.x = mainCam.position.x - 10
    elseif key == "right" then
        mainCam.position.x = mainCam.position.x + 10
    end

    if key == "kp+" then
        mainCam.zoom = mainCam.zoom + 0.1
        elseif key == "kp-" then
        mainCam.zoom = mainCam.zoom - 0.1
    end
    --print(key)
end