local fun = require('lib/fun')
local utils = require('utils')
require("lib/deepcopy").insert_deep_copy()

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
            
            local middleware_api = {
                dispatch = function (...)
                     return dispatch(table.unpack({...})) 
                    end,
                get_state = store:get_state()
            }
            
            local chain =  {middlewares[1](middleware_api)} 
            local old_store = table.deepcopy(store)
            dispatch = chain[1](old_store)
            store["dispatch"] = dispatch

            return store
        end    

    end
end

return M
