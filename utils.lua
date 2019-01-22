module("utils", package.seeall)

local fun = require('lib/fun')

extends = function(...)
    local args = {...}
    local tab = {}  
    for i1, k1 in ipairs(args) do
        for i2, k2 in pairs(k1) do
            tab[i2] = k2
        end
    end
    return tab
end

compose = function (...)
    local arg = {...}   
    return function (val)
        return fun.foldl(function (acc, x) return x(acc) end, fun.head(arg)(val), fun.tail(arg))
    end            
end