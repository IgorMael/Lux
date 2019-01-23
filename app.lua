local redux = require("lux")
local apply_middleware = require("apply_middleware").apply_middleware
local thunk = require("thunk").thunk
require("lib/deepcopy").insert_deep_copy()

local actions = {}

actions.create_item = function(item)
    return {type = "CREATE_ITEM", payload = item}
end

local items_reducer = function(state, action)
    state = state or {}
    action = table.deepcopy(action)
    state = state or  {}
    if action.type == "CREATE_ITEM" then
        new_state = table.deepcopy(state)
        table.insert(new_state, action.payload)
        return new_state
    elseif action.type == "DELETE_ITEM" then
        new_state = table.deepcopy(state)
        table.remove(new_state, action.payload)
        return new_state
    else
        return state
    end
end

local monster_reducer = function(state, action)
    state = state or {}
    action = table.deepcopy(action)
    state = state or  {}
    if action.type == "ADD_MONSTER" then
        new_state = table.deepcopy(state)
        table.insert(new_state, action.payload)
        return new_state
    elseif action.type == "DELETE_MONSTER" then
        new_state = table.deepcopy(state)
        table.remove(new_state, action.payload)
        return new_state
    else
        return state
    end
end


local main = function() 
    local reducers = redux.combine_reducers({item = items_reducer, monster = monster_reducer})
    local store = redux.create_store(reducers, nil, apply_middleware(thunk))
    local item = {
        type = "CREATE_ITEM",
        payload = {
            id = 1,
            nome = "Espada" 
        }
    }
    local monster = {
        type = "ADD_MONSTER",
        payload = {
            id = 1,
            nome = "Goblin" 
        }
    }
    store:dispatch(item)
--     store:dispatch(monster)
--     local item = {
--         type = "CREATE_ITEM",
--         payload = {
--             id = 2,
--             nome = "Machado" 
--         }
--     }
--     store:dispatch(item)

--     for k,v in pairs(store:get_state()) do 
--         print(k)
--         for k2,v2 in pairs(v) do
--             print("\t " .. v2["nome"])
--             -- for i, ent in pairs(v2) do
--             --     print(ent)
--             -- end
--         end
--     end

--     -- local a = {a = 1, b =  2,c = {a = 2}}
--     -- local b = clone_table(a)
--     -- a.c.a = 5
--     -- print(b.c.a)
end


main()