local thunk = {}
local createThunkMiddleware = function ()
    return function (api)
        local dispatch = api["dispatch"]
        local get_state = api["get_state"]
        return function (next)
            return function (action)
                print("wtf")
                -- print(next)
                -- for k,v in pairs(get_state) do
                --     print(k,v)
                -- end
                return next:dispatch(action)
            end
        end
    end
end

thunk.thunk = createThunkMiddleware()


return thunk

