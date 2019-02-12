local fun = require('deps.fun')
-- local utils = require('utils')
fun.compose = require('deps.compose').compose
table.deepcopy = require("deps.deepcopy").deepcopy


table.unpack = table.unpack or unpack

local M = {}
M.apply_middleware = function(...)
    local middlewares = {...}
    return function(create_store)
        return function(...)
            local store = create_store(table.unpack({...}))
            local dispatch = function()
                error("Dispatch is not ready yet", 2)
            end
            store["dispatch"] = fun.compose(store.dispatch, table.unpack(middlewares))

            return store
        end    

    end
end

return M