--// Resources
Renderer = require("src.graphics.renderer")
Sprite = require("src.graphics.objects.sprite")
Text = require("src.graphics.objects.text")
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

    txt =  Text.new("ajajaj")
    txt.position.x = 75

    TIME = 0
end

--// LOVE UPDATE
function love.update(dt)
    TIME = TIME + dt
    obj.rotation = obj.rotation + 0.5 * dt

    if TIME >= 5 then
        obj:setImage("?")
    end
end 

--// LOVE DRAW
function love.draw()
    renderer:addObject("main", obj)
    renderer:addObject("ui", obj)
    renderer:addObject("ui", txt)
    renderer:draw()
end

function love.keypressed(key)

    if key == "up" then
        uiFrame.position.y = uiFrame.position.y - 10
    elseif key == "down" then
        uiFrame.position.y = uiFrame.position.y + 10
    elseif key == "left" then
        uiFrame.position.x = uiFrame.position.x - 10
    elseif key == "right" then
        uiFrame.position.x = uiFrame.position.x + 10
    end

    if key == "kp+" then
        uiFrame.zoom = uiFrame.zoom + 0.1
        elseif key == "kp-" then
        uiFrame.zoom = uiFrame.zoom - 0.1
    end
    --print(key)
end