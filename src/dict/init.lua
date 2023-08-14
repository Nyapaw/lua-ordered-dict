--dict.lua
--2023-08-14
--@author iiau

local rbtree = require(script:WaitForChild("rbtree"))

local dict = {}
dict.__index = dict

--[[
    dict.new(<pair>...) -> dict

    dict:init(<pair>...)
    dict:set(key, value)
    dict:clear()
    dict:get(key) -> value
    dict:pairs() -> iterator
    dict:table() -> table
]]
dict.new = function(...) -- key value pairs
    local self = setmetatable({}, dict)
    self.tree = rbtree.new(function(a, b)
        return a.cnt < b.cnt and -1 or a.cnt > b.cnt and 1 or 0
    end)
    self.map = {}
    --note: on 64 bit systems, this counter goes up to 2^1024-1
    self.count = -1

    self:init(...)
    return self
end

dict.__len = function(self)
    return #self.tree
end

function dict:init(...)
    for _, pair in pairs({...}) do
        self:set(pair[1], pair[2])
    end
end

function dict:clear()
    self.tree:clear()
    table.clear(self.map)
    self.count = -1
end

function dict:set(key, value)
    assert(key ~= nil, "key cannot be nil")
    if value == nil then
        self.tree:remove(self.map[key])
        self.map[key] = nil

        if self.tree:empty() then
            self.count = -1
        end
    else
        self.count = self.count + 1

        local node = self.map[key]
        if node then
            if node.v == value then
                return
            end
            self.tree:update(node, function(obj)
                obj.cnt = self.count
                obj.v = value
            end)
        else
            local tbl = {k = key, v = value, cnt = self.count}
            self.tree:add(tbl)
            self.map[key] = tbl
        end
    end
end
dict.Set = dict.set

function dict:get(key)
    return self.map[key] and self.map[key].v
end
dict.Get = dict.get

function dict:pairs()
    local inorder = self.tree:inOrderArray()
    local i = 0
    return function()
        i = i + 1
        local v = inorder[i]
        if v then
            return v.k, v.v
        end
    end
end

function dict:table()
    local tbl = {}
    for k, v in self:pairs() do
        tbl[k.k] = v.v
    end
    return tbl
end

return dict