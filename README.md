# Dumb Collider

The simplest collision detection library for LÖVE 2D. No fancy shapes, no complex physics - just dead simple rectangle collision checking that works. I actually made this since i didn't want to use windfield

## Why Dumb Collider?

Sometimes you don't need a full physics engine. Sometimes you just want to check if your player hit a wall or collected a coin. Dumb Collider does exactly that - nothing more, nothing less.

## Installation

Just drop the `collision.lua` file into your project and require it:

```lua
local collision = require('collision')
```

## Usage

### Basic Collision Check

Check if two rectangles are overlapping:

```lua
local player = {x = 10, y = 10, width = 32, height = 32}
local wall = {x = 40, y = 10, width = 64, height = 32}

if collision.check(player, wall) then
    print("Player hit the wall!")
end
```

### Check Against Multiple Objects

Check if a rectangle collides with any rectangle in a list:

```lua
local player = {x = 10, y = 10, width = 32, height = 32}
local enemies = {
    {x = 50, y = 10, width = 32, height = 32},
    {x = 100, y = 50, width = 32, height = 32},
    {x = 150, y = 80, width = 32, height = 32}
}

local hitEnemy, enemyIndex = collision.checkList(player, enemies)
if hitEnemy then
    print("Player hit enemy at position " .. enemyIndex)
    -- Remove the enemy or handle the collision
    table.remove(enemies, enemyIndex)
end
```

## API Reference

### `collision.check(rect1, rect2)`

Checks if two rectangles are overlapping.

**Parameters:**
- `rect1` - First rectangle `{x, y, width, height}`
- `rect2` - Second rectangle `{x, y, width, height}`

**Returns:**
- `boolean` - `true` if rectangles overlap, `false` otherwise

### `collision.checkList(rect, list)`

Checks if a rectangle overlaps with any rectangle in a list.

**Parameters:**
- `rect` - Rectangle to check `{x, y, width, height}`
- `list` - Array of rectangles to check against

**Returns:**
- `object, number` - The first overlapping rectangle and its index in the list
- `nil` - If no collision is detected

## Rectangle Format

All rectangles must have these properties:
- `x` - Left edge position
- `y` - Top edge position  
- `width` - Rectangle width
- `height` - Rectangle height

## Example: Simple Platformer Movement

```lua
local collision = require('collision')

local player = {x = 100, y = 100, width = 32, height = 32}
local walls = {
    {x = 0, y = 150, width = 400, height = 50},    -- Ground
    {x = 200, y = 100, width = 50, height = 50}    -- Platform
}

function love.update(dt)
    local newX, newY = player.x, player.y
    
    -- Move player
    if love.keyboard.isDown('left') then
        newX = newX - 200 * dt
    elseif love.keyboard.isDown('right') then
        newX = newX + 200 * dt
    end
    
    -- Check horizontal collision
    local testRect = {x = newX, y = player.y, width = player.width, height = player.height}
    if not collision.checkList(testRect, walls) then
        player.x = newX  -- Only move if no collision
    end
    
    -- Apply gravity and check vertical collision
    newY = newY + 300 * dt  -- Gravity
    testRect = {x = player.x, y = newY, width = player.width, height = player.height}
    if not collision.checkList(testRect, walls) then
        player.y = newY
    end
end
```

## License

Public domain. Use it however you want.

---

*Dumb Collider: Because sometimes simple is better.*
