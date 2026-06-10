--// Module
local RenderObj = require("src.graphics.objects.render_object")

--// Var

local withoutTexture = "assets/images/notexture.png"

--// Class
local Sprite = setmetatable({}, {__index = RenderObj})
Sprite.__index = Sprite

function Sprite.new(img)
    if type(img) ~= "string" or not love.filesystem.getInfo(img) then
        img = withoutTexture
    end

    local self = setmetatable(RenderObj.new(), Sprite)

    self.super = RenderObj 
    self.img = love.graphics.newImage(img)
    self.pivot = {x = 0.5, y = 0.5}

    return self
end

function Sprite:draw()
    --love.graphics.push("all")
    if self.img then
        -- Si img es un string, cargar la imagen, si no usar el objeto ya cargado
        local img = self.img
        local origin = {
            x = img:getWidth() * self.pivot.x,
            y = img:getHeight() * self.pivot.y
        }
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

    --love.graphics.pop()
end



return Sprite