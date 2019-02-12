local actions = {}

actions.add_monster = function(id, name)
    return {
        type = "ADD_MONSTER",
        payload = {
            id = id,
            name = name
        }
    }
end

actions.create_item = function(id, name)
    return {
        type = "CREATE_ITEM",
        payload = {
            id = id,
            name = name
        }
    }
end

return actions