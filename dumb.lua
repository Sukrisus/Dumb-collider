-- Dumb Collider - The simplest collision library ever!

local collision = {}

-- Check if two rectangles are touching
function collision.check(rect1, rect2)
    return rect1.x < rect2.x + rect2.width and
           rect1.x + rect1.width > rect2.x and
           rect1.y < rect2.y + rect2.height and
           rect1.y + rect1.height > rect2.y
end

-- Check if one rectangle touches any rectangle in a list
function collision.checkList(rect, list)
    for i, other in ipairs(list) do
        if collision.check(rect, other) then
            return other, i  -- Return the rectangle we hit and its position in the list
        end
    end
    return nil  -- No collision
end

return collision
