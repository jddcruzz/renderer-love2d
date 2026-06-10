local Camera = {}
Camera.__index = Camera

function Camera.new()
    local self = setmetatable({}, Camera)

    -- Transform 
    self.position = { x = 0,y = 0 }
    self.zoom = 1

    return self
end

return Camera