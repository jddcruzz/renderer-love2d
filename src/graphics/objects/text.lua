--// Module
local RenderObj = require("src.graphics.objects.render_object")

--// Class
local Text = setmetatable({}, {__index = RenderObj})
Text.__index = Text

-- Constructor
function Text.new(txt)
    local self = setmetatable(RenderObj.new(), Text)

    -- Text
    self.textSize = 1
    self.textColor = {1, 1, 1}
    self.text = txt or "Text"

    -- Font
    self.fontSize = 11
    self.font = self:setFont()

    -- Texto a dibujar
    self._textObj = love.graphics.newText(self.font, self.text)

    return self
end

-- Text
function Text:setText(txt)
    if type(txt) ~= "string" then return end
    
    self.text = txt
    -- Texto a dibujar
    self._textObj = love.graphics.newText(self.font, self.text)
end

function Text:setFont(path, size)
    size = size or 12 

    if path and love.filesystem.getInfo(path) then
        self.font = love.graphics.newFont(path, size)
    else
        self.font = love.graphics.newFont(size)
    end

    -- Texto a dibujar
    self._textObj = love.graphics.newText(self.font, self.text)

    return self.font
end

-- Draw
function Text:draw() 
   love.graphics.push("all")

    if self.text then
        -- Posiciona el texto
        love.graphics.translate(self.position.x, self.position.y)
        love.graphics.rotate(math.rad(self.rotation))

        -- Dibuja el texto
        love.graphics.draw(self._textObj)
    end

    love.graphics.pop()
end

return Text