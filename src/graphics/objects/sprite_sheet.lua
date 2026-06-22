--// Module
local Sprite = require("src.graphics.objects.sprite")

--// Var

--// Class
local SpriteSheet = setmetatable({}, {__index = Sprite})
SpriteSheet.__index = SpriteSheet

function SpriteSheet.new(file, quadW, quadH)
    local self = setmetatable(Sprite.new(), SpriteSheet)

    -- Quads
    self.quad = 1
    self.quads = {}
    
    -- Configura la imagen
    self:setImage(file, quadW, quadH)

    return self
end

-- Configura los quads cuando se necesita, como cuando se cambia la imagen
function SpriteSheet:_setupQuads()

    -- Limpia los quads antiguos
    self.quads = {}

    -- Tamaños
    local sh = self.sheetSize.h
    local sw = self.sheetSize.w
    local qh = self.quadSize.h
    local qw = self.quadSize.w

    local index = 1

    -- Crea todos los quads
    for y = 0, sh -qh, qh do 
        for x = 0, sw -qw, qw do

            self.quads[index] = love.graphics.newQuad(
                x,
                y,
                qw,
                qh,
                sw,
                sh
            )
            index = index +1

        end
    end

    self.quad = 1
end

function SpriteSheet:setImage(file, quadW, quadH)
    Sprite.setImage(self, file)
    
    -- Tamaño de la sheet y los quads
    self.sheetSize = {
        w = self.img:getWidth(), 
        h = self.img:getHeight()
    }
    self.quadSize = {
        -- Asegura un valor numerico
        w = tonumber(quadW) or self.sheetSize.w,
        h = tonumber(quadH) or self.sheetSize.h
    }

    self:_setupQuads()
end

function SpriteSheet:setQuad(n)
    -- Asegura que n sea un numero
    n = tonumber(n) or 1

    if self.quads[n] then
        self.quad = n
    end
end

function SpriteSheet:draw()
    
    if self.img and self.quad then 

        local ox = self.quadSize.w * self.pivot.x
        local oy = self.quadSize.h * self.pivot.y

        -- Dibuja
        love.graphics.draw(
            -- Sheet y quad
            self.img,
            self.quads[self.quad],
            -- Posicion y rotacion
            self.position.x,
            self.position.y,
            self.rotation,
            -- Ajusta la escala con el tamaño en px del objeto
            self.size.w / self.quadSize.w, 
            self.size.h / self.quadSize.h, 
            -- Centran el sprite en el origin
            ox,
            oy
        )
    end
end

return SpriteSheet