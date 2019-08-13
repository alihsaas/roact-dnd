local DragDropContext = {}
DragDropContext.__index = DragDropContext

function DragDropContext.new()
    local self = {
        _dragSources = {},
        _dropTargets = {},
    }
    return setmetatable(self, DragDropContext)
end

function DragDropContext:AddSource(src, dropId, data)
    assert(typeof(src) == "Instance" and src:IsA("GuiObject"))
    assert(typeof(dropId) == "string" or typeof(dropId) == "number")
    assert(data ~= nil)

    self._dragSources[src] = { dropId = dropId, data = data }
end

function DragDropContext:AddTarget(src, dropId, onDrop)
    assert(typeof(src) == "Instance" and src:IsA("GuiObject"))
    assert(typeof(dropId) == "string" or typeof(dropId) == "number")
    assert(typeof(onDrop) == "function")

    self._dropTargets[src] = { dropId = dropId, onDrop = onDrop }
end

function DragDropContext:RemoveTarget(src)
    assert(typeof(src) == "Instance")
    self._dropTargets[src] = nil
end

function DragDropContext:RemoveSource(src)
    assert(typeof(src) == "Instance")
    self._dragSources[src] = nil
end

DragDropContext.Default = DragDropContext.new()

return DragDropContext