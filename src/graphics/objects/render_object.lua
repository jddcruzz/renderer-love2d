local Object = {}
Object.__index = Object

function Object.new()
    local self = setmetatable({}, Object)

    -- Transform
    self.position = {x = 0, y = 0}
    self.size = {w = 50, h = 50}
    self.rotation = 0

    return self
end

-- Solo para compatibilidad
function Object:draw() 
end

return Object