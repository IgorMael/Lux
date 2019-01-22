module("redux", package.seeall)

local fun = require('lib/fun')

create_store = function(reducer, initial_state, enhancer)
    local store = store or {}
    store["reducers"] = reducer
    store["middleware"] = {}
    store["data"] = {}
    if enhancer then
        return enhancer(create_store)(reducer, initial_state)
    -- store.dispatch = function(store, action)

    --     for k,v in pairs(store["reducers"]) do
    --         store["data"][k] = v(store["data"][k], action)

    --     end
    --     return store
    -- end
    -- for k,v in pairs(store["reducers"]) do    
    --     store["data"][k] = v(nil, {type= "LUA_REDUX_START_STORE"})
    -- end
    return store
end



apply_middleware = function(...middlewares)
    
    store.dispatch = f()(store.dispatch)
end

combine_reducers = function(reducer_list)
    local combined_reducers = {}
    for k,v in pairs(reducer_list) do
        combined_reducers[k] = v
    end
    return combined_reducers
end

fun.compose = function (a,b) 
        return a(b)
end

fa = function (l)
     return "-" .. l 
end

fb = function(l)
    return  "+" .. l
end



fn = tst(fa, fb)
print(fn("abc"))
-- ntst = tst(fa,fb)
-- print(ntst("a"))