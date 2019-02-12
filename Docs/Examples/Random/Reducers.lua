local reducers = {}
local deepcopy = require("src.deps.deepcopy").deepcopy
reducers.items_reducer = function(state, action)
    state = state or {}
    action = deepcopy(action)
    state = state or  {}
    if action.type == "CREATE_ITEM" then
        new_state = deepcopy(state)
        table.insert(new_state, action.payload)
        return new_state
    elseif action.type == "DELETE_ITEM" then
        new_state = deepcopy(state)
        table.remove(new_state, action.payload)
        return new_state
    else
        return state
    end
end

reducers.monster_reducer = function(state, action)
    state = state or {}
    action = table.deepcopy(action)
    state = state or  {}
    if action.type == "ADD_MONSTER" then
        new_state = deepcopy(state)
        table.insert(new_state, action.payload)
        return new_state
    elseif action.type == "DELETE_MONSTER" then
        new_state = deepcopy(state)
        table.remove(new_state, action.payload)
        return new_state
    else
        return state
    end
end

return reducers