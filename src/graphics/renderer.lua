--// Resources
Frame = require("src.graphics.frame")

--// Class
local Renderer = {}
Renderer.__index = Renderer

-- Instance
function Renderer.new()
    local self = setmetatable({}, Renderer)

    self._frames = {}   -- Frames a Rendererizar
    self._orderedFrames = {}

    return self
end

-- Private functionsw
function Renderer:_sortFrames()
    table.sort(self._orderedFrames, function(a, b) 
        return a.zIndex < b.zIndex
    end)
end

-- Frames
function Renderer:addFrame(id, hasCamera, frameConfig)
    if not id then return end

    -- Crea y registra el frame
    local frame = Frame.new(hasCamera, frameConfig)
    frame.frameId = id
    self._frames[id] = frame

    -- Frames ordenados
    table.insert(self._orderedFrames, frame)
    self:_sortFrames()
    
    return self._frames[id]
end

function Renderer:removeFrame(id)
    -- Borra el frame
    self._frames[id] = nil
    
    -- Frames ordenados
    for i, frame in ipairs(self._orderedFrames) do 
        if frame.frameId == id then 
            table.remove(self._orderedFrames, i)
            break
        end
    end
    self:_sortFrames()
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
    for id, frame in ipairs(self._orderedFrames) do
        
        if frame.enabled then 

            -- Guardar estado actual
            love.graphics.push("all")
            -- Aplicar transformaciones del frame y scissor para limitar el area de dibujo
            love.graphics.translate(frame.position.x, frame.position.y)
            love.graphics.setScissor(frame.position.x, frame.position.y, frame.size.w, frame.size.h)
            
            -- Transformaciones de la camara
            if frame.camera then
                local cam = frame.camera
                love.graphics.scale(cam.zoom, cam.zoom)
                love.graphics.translate(-cam.position.x, -cam.position.y)
            end
            -- Dibujar objetos en el frame
            for i, obj in ipairs(frame.objects) do
                if obj.enabled then 
                    obj:draw()
                end
            end
            -- Limpiar objetos
            for k in pairs(frame.objects) do
                frame.objects[k] = nil
            end

            -- Restaura transformaciones
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