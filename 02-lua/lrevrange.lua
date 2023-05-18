-- script implementing a lrevrange

-- example: 
-- my_list : 0 1 2 3 4 5 6 7 8 9 10
-- lrevrange my_list 4 8
-- 7 6 5 4

local key = KEYS[1]
local start = tonumber(ARGV[1])
local stop = tonumber(ARGV[2])
local length = redis.call('llen', key)

-- Handle negative indices
if start < 0 then
    start = length + start
end

if stop < 0 then
    stop = length + stop
end

-- Perform the reverse range retrieval
local result = {}
for i = start, stop, -1 do
    local value = redis.call('lindex', key, i)
    table.insert(result, value)
end

return result
