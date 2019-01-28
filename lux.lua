local fun = require('utils/fun')
local apply_middleware = require('apply_middleware').apply_middleware

local table = table
table.deepcopy =  require("utils.deepcopy").deepcopy

local M = {}

M.create_store = function(reducer, initial_state, enhancer)
    if enhancer then
        return enhancer(M.create_store)(reducer, initial_state)
    end
    local store = store or {}
    store["state"] = initial_state or {}
    store["listeners"] = {}
    store["reducer"] = reducer
    
    function store:get_state()
        return table.deepcopy(self.state)
    end

    function store:subscribe(callback)
        table.insert(self.listeners, callback)
        return function() 
            local index = nil
            for k,v in pairs(self.listeners) do
                if v == callback then
                    index = k
                end
            end
            table.remove(self.listeners, index)
        end
    end

    function store:dispatch(action)
        print(action.type)
        if type(action) ~= "table" then
            error("action must be a table")
        end

        self.state = self.reducer(self:get_state(), action)
        for k,listener in pairs(self.listeners) do
            listener()
        end
    end
    return store
end

M.combine_reducers = function(reducer_list)
    local combined_reducers = {}
    for k,v in pairs(reducer_list) do
        if type(v) ~= "function" then
            error("The reducers must be functions.")
        end
        combined_reducers[k] = v
    end
    return function(state, action)
        state = state or {}
        local new_state = table.deepcopy(state)
        for k,v in pairs(combined_reducers) do
            new_state[k] = v(state[k], action)
        end
        return new_state
    end
end

return M