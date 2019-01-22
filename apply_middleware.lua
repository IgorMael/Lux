local fun = require('lib/fun')
local utils = require('utils')


local apply_middleware = function(...)
    local middlewares = {...}
    return function(create_store)
        return functionx(...)
            local args = {...}
            local dispatch = function()
                return "error" -- @TODO Colocar erro
            end
        local middleware_api = {
            get_state = store.get_state,
            dispatch = function(...) local args = {...} return dispatch(args) end
        }
        local chain = fun.map(function (middleware) return middleware(middleware_api) end, middlewares)
        dispatch = utilscompose(chain)(store.dispatch)


        return utils.extends(store, dispatch)
        end
    end
end


        