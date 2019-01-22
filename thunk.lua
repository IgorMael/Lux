local thunk = {}
local function createThunkMiddleware ()
    return function (obj)
        return function (next)
            return function (action)
                print("CHEGO, PORRA, É UM MILAGRE")
                return next(action)
            end
        end
    end
end

thunk.thunk = createThunkMiddleware()

return thunk


