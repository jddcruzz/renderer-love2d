--// Resources
Camera = require("src.graphics.camera")

--// Class
local Frame = {}
Frame.__index = Frame

function Frame.new(hasCamera)
    local self = setmetatable({}, Frame)

    -- Transform 
    self.position = {x = 0, y = 0}
    self.size = {w = 250, h = 250}
    self.rotation = 0
    --self.pivot = {x = self.size.w / 2, y = self.size.h / 2}

    self.enabled = true
    self.camera = hasCamera and Camera.new() or nil
    self.objects = {}

    self.drawLimits = true

    return self
end

function Frame:getCamera()
    return self.camera
end

return Frame