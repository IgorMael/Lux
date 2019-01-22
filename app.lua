local redux = require("redux")
local imutable = require("imutable")


local actions = {}

actions.create_item = function(item)
    return {type = "CREATE_ITEM", payload = item}
end

local items_reducer = function(state, action)
    action = imutable.clone_table(action)
    state = state or  {}
    if action.type == "CREATE_ITEM" then
        new_state = imutable.clone_table(state)
        table.insert(new_state, action.payload)
        return new_state
    elseif action.type == "DELETE_ITEM" then
        new_state = imutable.clone_table(state)
        new_state = imutable.delete_key(new_state, action.payload)
        return new_state
    else
        return state
    end
end

local main = function() 
    local reducers = redux.combine_reducers({item = items_reducer})
    local store = redux.create_store(reducers)
    local item = {
        type = "CREATE_ITEM",
        payload = {
            id = 1,
            nome = "Espada" 
        }
    }
    store:dispatch(item)
    local item = {
        type = "CREATE_ITEM",
        payload = {
            id = 2,
            nome = "Machado" 
        }
    }
    store:dispatch(item)
    local item = {
        type = "DELETE_ITEM",
        payload = 1
    }
    store:dispatch(item)
    
    for k,v in pairs(store["data"]["item"]) do
        print(k,v)
    end

    -- for k,v in pairs(store["data"]["items"]) do 
    --     print(k,v)
    -- end

    -- local a = {a = 1, b =  2,c = {a = 2}}
    -- local b = clone_table(a)
    -- a.c.a = 5
    -- print(b.c.a)
end


main()