local lux = require 'src.lux'

local reducers = require 'Examples.Random.Reducers'
local actions = require 'Examples.Random.Actions'

local main = function() 
    local reducers = lux.combine_reducers({item = reducers.item_reducer, monster = reducers.monster_reducer})
    local store = lux.create_store(reducers)
    local item = {
        type = "CREATE_ITEM",
        payload = {
            id = 1,
            nome = "Sword" 
        }
    }
    local monster = {
        type = "ADD_MONSTER",
        payload = {
            id = 1,
            nome = "Goblin" 
        }
    }
    store.dispatch(store, actions.add_monster(1, "Goblin"))
    store.dispatch(store, actions.add_monster(2, "Troll"))
    store.dispatch(store, actions.create_item(1, "Sword"))
end


main()