--// Module
local RenderObj = require("src.graphics.objects.render_object")

--// Var
local texturePath = "assets/images/notexture.png"
local missingTexture = love.graphics.newImage(texturePath)

--// Class
local Sprite = setmetatable({}, {__index = RenderObj})
Sprite.__index = Sprite

function Sprite.new(file)
    local self = setmetatable(RenderObj.new(), Sprite)

    -- Config de imagen
    self.imageFilter = {"nearest", "nearest"}
    self.img = self:_resolveImage(file)
    self.pivot = {x = 0.5, y = 0.5}

    return self
end

function Sprite:_resolveImage(file)
    -- Caso 0. "image" se establece com textura perdida desde el inicio
    local image = missingTexture
    file = file or "null"

    -- Caso 1. "file" es una ruta valida hacia una imagen
    if type(file) == "string" and love.filesystem.getInfo(file) then
        image = love.graphics.newImage(file)

    -- Caso 2. "file" es un objeto de imagen
    elseif type(file) == "userdata" and file.typeOf and file:typeOf("Image") then
        image = file
    end
    
    -- Establece el filtro de la imagen
    image:setFilter(self.imageFilter[1], self.imageFilter[2])

    return image
end

function Sprite:setImage(file)
    local image = self:_resolveImage(file)
    self.img = image
end

function Sprite:draw()
    if self.img then
        local img = self.img

        local ox = img:getWidth() * self.pivot.x
        local oy = img:getHeight() * self.pivot.y

        -- Dibuja
        love.graphics.draw(
            img,
            -- Posicion y rotacion
            self.position.x,
            self.position.y,
            self.rotation, 
            -- Ajusta la escala con el tamaño en px del objeto
            self.size.w / img:getWidth(), 
            self.size.h / img:getHeight(), 
            -- Centran el sprite en el origin
            origin.x, 
            origin.y
        )

    end
end

return Sprite