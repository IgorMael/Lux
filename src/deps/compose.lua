local fun = require('src.deps.fun')
local M = {}
local unpack = table.unpack or unpack

M.compose = function(...)
    local functions = {...}
    if  #functions == 0 then
        return function(arg)
            return arg
        end
    elseif #functions == 1 then
        return functions[1]
    else
        return fun.foldl(function (acc, f)
             return function(...)
                local args = {...}
                return acc(f(unpack(args))) 
            end 
        end, fun.head(functions), fun.tail(functions))
    end
end

return M

--local a=require('./utils/fun')local b={}local unpack=table.unpack or unpack;b.compose=function(...)local c={...}if#c==0 then return function(d)return d end elseif#c==1 then return c[1]else return a.foldl(function(e,f)return function(...)local g={...}return e(f(unpack(g)))end end,a.head(c),a.tail(c))end end;return b