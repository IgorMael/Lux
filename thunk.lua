local thunk = {}
local createThunkMiddleware = function ()
    return function (store, action)
        print(action.type)
        return store, action
    end
end

thunk.thunk = createThunkMiddleware()


return thunk

