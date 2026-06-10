--// Func
local function getMod(provider, classname)
    local value = provider.classes[classname]

    if type(value) == "string" then
        local mod = require(value)
        provider.classes[classname] = mod -- cache
        return mod
    end

    return value
end

--// Class
local Provider = {}

Provider.classes = {
    ["render_object"]   = "src.graphics.objects.render_object";
    ["rectangle"]       = "src.graphics.objects.rectangle";
} 
    
function Provider.new(classname, ...)
    if type(classname) ~= "string" then return end
    local mod = getMod(Provider, classname)

    return mod and mod.new(...)
end

function Provider.get(classname)
    if type(classname) ~= "string" then return end
    local mod = getMod(Provider, classname)
    
    return mod
end

return Provider