local fun = require('lib/fun')
local utils = require('utils')

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
                get_state = store.get_state,
                dispatch = function (...)
                     return dispatch(table.unpack({...})) 
                    end
            }
            
            local chain =  {middlewares[1](middleware_api)} 
            print(middlewares[1])
            -- fun.map(function (middleware) 
            --     return middleware(middleware_api) 
            -- end, middlewares)

            dispatch = chain[1](store.dispatch)
            return utils.extends(store, dispatch)
        end    

    end
end

return M
