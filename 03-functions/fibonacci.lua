#!lua name=jlg

-- @description This function set to the key a list containing the first N elements of the fibonacci sequence.
-- Parameters:
--   key: The key to increment
--   length: the first N elements to add to the list
-- Returns:
--   length
local function fibonacci(keys, args)
    local key = keys[1]
    local length = tonumber(args[1])

    local n = 0
    local m = 1
    local result = {}

    redis.call('del', key)

    redis.call('rpush', key, n)
    if length == 1 then
        return 1
    end

    redis.call('rpush', key, m)
    if length == 2 then
        return 2
    end

    for i = 2, length - 1, 1 do
        local value = n + m
        redis.call('rpush', key, value)
        n = m
        m = value
    end

    return length
end

redis.register_function({
    function_name = 'fibonacci',
    callback = fibonacci,
    description = 'set a key with a list containing the fibonacci sequence with N elements'
})

