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

    local image = self:_resolveImage(file)

    self.super = RenderObj 
    self.img = image
    self.pivot = {x = 0.5, y = 0.5}

    return self
end

function Sprite:_resolveImage(file)
    -- Caso 0. "image" se establece com textura perdida desde el inicio
    local image = missingTexture
    
    -- Caso 1. "file" es una ruta valida hacia una imagen
    if type(file) == "string" and love.filesystem.getInfo(file) then
        image = love.graphics.newImage(file)
    -- Caso 2. "file" es un objeto de imagen
    elseif file.typeOf and file:typeOf("Image") then
        image = file
    end

    return image
end

function Sprite:setImage(file)
    local image = self:_resolveImage(file)
    self.img = image
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