--// Resources
Camera = require("src.graphics.camera")

--// Class
local Frame = {}
Frame.__index = Frame

function Frame.new(hasCamera, config)
    local self = setmetatable({}, Frame)

    -- Transform 
    self.position = {x = 100, y = 0}
    self.size = {w = 250, h = 250}
    self.rotation = 0
    self.zIndex = 0
    --self.pivot = {x = self.size.w / 2, y = self.size.h / 2}

    -- Properties
    self.enabled = true
    self.drawLimits = true
    self.camera = hasCamera and Camera.new() or nil
    self.objects = {}

     -- Aplica la configuracion inicial
    if type(config) == "table" then 
        for i, v in pairs(config) do
            self[i] = v
        end
    end

    return self
end

function Frame:setPosition(x, y)
    if type(x) ~= "number" or type(y) ~= "number" then return end
    self.position.x = x
    self.position.y = y
end

function Frame:setSize(w, h)
    if type(w) ~= "number" or type(h) ~= "number" then return end
    self.size.w = w
    self.size.h = h
end

function Frame:getCamera()
    return self.camera
end

return Frame