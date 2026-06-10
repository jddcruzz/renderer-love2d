--// Resources
Frame = require("src.graphics.frame")

--// Class
local Renderer = {}
Renderer.__index = Renderer

-- Instance
function Renderer.new()
    local self = setmetatable({}, Renderer)

    self._frames = {}   -- Frames a Rendererizar



    return self
end

-- Frames
function Renderer:addFrame(id, zIndex, frame)
    if not id then return end

    frame = frame or Frame.new(true)
    frame.zIndex = zIndex or 0
    self._frames[id] = frame
end

function Renderer:removeFrame(id)
    self._frames[id] = nil
end

function Renderer:getFrame(id)
    return self._frames[id]
end

-- Objects
function Renderer:addObject(frameId, obj)
    local frame = self:getFrame(frameId)
    if not frame then return end

    table.insert(frame.objects, obj)
end

-- Render
function Renderer:draw()
    for id, frame in pairs(self._frames) do
        
        if frame.enabled then 

            -- Guardar estado actual y aplica recorte para el frame
            love.graphics.push("all")
            love.graphics.setScissor(frame.position.x, frame.position.y, frame.size.w, frame.size.h)
            
            -- Transformaciones de la camara
            if frame.camera then
                local cam = frame.camera
                love.graphics.translate(-cam.position.x, -cam.position.y)
                love.graphics.scale(cam.zoom, cam.zoom)
            end
            -- Dibujar objetos en el frame
            for i, obj in pairs(frame.objects) do
                obj:draw()
            end
            -- Limpiar objetos
            for k in pairs(frame.objects) do
                frame.objects[k] = nil
            end

            -- Restaurar transformaciones
            love.graphics.pop()

            -- Dibujar limites del frame (opcional)
            if frame.drawLimits then
                love.graphics.setColor(1, 1, 0) 
                love.graphics.rectangle("line", frame.position.x, frame.position.y, frame.size.w, frame.size.h)
                love.graphics.setColor(1, 1, 1) 
            end

        end

    end
end


return Renderer