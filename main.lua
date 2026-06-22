--// Resources
Renderer = require("src.graphics.renderer")
Sprite = require("src.graphics.objects.sprite")
Text = require("src.graphics.objects.text")
SpriteSheet = require("src.graphics.objects.sprite_sheet")

--// LOVE LOAD
function love.load()
    
    renderer = Renderer.new()

    mainFrame = renderer:addFrame("main", true)
    mainCam = mainFrame:getCamera()

    obj = SpriteSheet.new("assets/images/DinoSprites-vita.png",24, 24)
    obj.position.x = 50
    obj.position.y = 25

    local frameConfig = {
        position = {x = 100, y = 200},
        size = {w = 250, h = 50},
        zIndex = 10
    }
    uiFrame = renderer:addFrame("ui", false, frameConfig)
    uiCam = uiFrame:getCamera()

    txt =  Text.new("ajajaj")
    txt.position.x = 75

    TIME = 0

    frameRate = 12
    frameTime = 0
    lastquad = #obj.quads
    quad = 1
end

--// LOVE UPDATE
function love.update(dt)
    TIME = TIME + dt
    --obj.rotation = obj.rotation + 0.5 * dt

    frameTime = frameTime +dt
    local ftime = 1/frameRate

    if frameTime >= ftime then
        frameTime = frameTime -ftime

        quad = (quad % 24) +1
        obj:setQuad(quad)
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