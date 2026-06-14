--// Module
local RenderObj = require("src.graphics.objects.render_object")

--// Var

--// Class
local Quad = setmetatable({}, {__index = RenderObj})
Quad.__index = Quad

function Quad.new(img)
    local self = setmetatable(RenderObj.new(), Quad)

    self.sheet = img
    self.quads = {}

    



    return self
end

function Quad:draw()
    love.graphics.newQuad(x (number), y (number), width (number), height (number), sw (number), sh (number))
end
