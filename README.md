# Lux

Redux on Lua

## What it does?

This module implements major redux features on Lua. You can create a store, dispatch actions and manage your state.

## Installation and Usage

### Installing

You can install this package using the [OPM](https://opm.openresty.org/)

```
opm install IgorMael/Lux
```

### Creating a store

To create a store you should call **create_store** function, it takes a reducer (to use multiple reducers you need combine them with combine_reducers), an optional initial_state and an optional store enhancer

```lua
create_store = function(reducer, initial_state, enhancer)
```

An Example

```lua
local lux = require 'lux'
local reducer = require 'Reducer'

local store = lux.create_store(reducer)
```

### Combining reducers

In most of the real world applications you will want to use more than one reducer. To do so you need call the combine_reducers function

```lua
    combine_reducers = function(reducer_list)
```

An example

```lua
    local lux = require 'lux'

    local reducers = lux.combine_reducers({item = reducers.item_reducer, monster = reducers.monster_reducer})
    local store = lux.create_store(reducers)
```

### Aplying a store enhancer

    apply_middleware is an example of store enhancer, it modifies the dispatch function with middlewares. An example of middleware will soon be disponibilized,
    ```
         apply_middleware = function(...)
    ```

### Dispatching actions

An action must be a lua table with the type field and optional payload

```lua
store:dispatch(action)
```

And an example

```lua
local lux = require 'lux'
local store = lux.create_store(reducer)

local create_foo = function(name, bar_level)
    return {
        type = "ADD_MONSTER",
        payload = {
            id = id,
            name = name
        }
    }
end

store:dispatch(create_foo("FOOBAR", 12))
```

### Subscribing

You can subscribe to the store

```lua
    store:subscribe(callback)
```

Example:

```lua
    local lux = require 'lux'
local store = lux.create_store(reducer)

local create_foo = function(name, bar_level)
    return {
        type = "ADD_MONSTER",
        payload = {
            id = id,
            name = name
        }
    }
end

store:subscribe(function() print("What a dispatch! Beautiful!")) -- callback will be called after ever dispatch

```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
