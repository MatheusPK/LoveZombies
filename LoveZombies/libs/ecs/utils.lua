local path = string.match(..., "(.*%.).*$")
local class = require(path .. 'class')

Utils = class('Utils')

-- Swap two elements inside a table and their hash map values
function Utils:swap(table, e1, e2)
    local pos1, pos2 = table[e1], table[e2]
    table[pos1], table[pos2] = table[pos2], table[pos1]
    table[e1], table[e2] = table[e2], table[e1]
end

function Utils:matchArchetypePattern(pattern1, pattern2)
    return string.match(pattern1, pattern2) ~= nil
end

function Utils:printTable(table)
    for index, value in ipairs(table) do print(index, value) end
end

return Utils