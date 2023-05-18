-- fibonacci key length

-- example: fibonacci toto 10
-- lrange toto 0 -1
-- 0 1 1 2 3 5 8 13 21 34

local key = KEYS[1]
local length = tonumber(ARGV[1])

local n = 0
local m = 1
local result = {}

redis.call('del', key)

redis.call('rpush', key, n)
if length == 1
then
    return 1
end

redis.call('rpush', key, m)
if length == 2
then
    return 2
end

for i = 2, length - 1, 1 do
    local value = n + m
    redis.call('rpush', key, value)
    n = m
    m = value
end

return length