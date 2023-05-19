#!lua name=jlg

-- Set to a given key a list containing the first N elements of the fibonacci sequence.
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

---------------------------------------

-- Sleep is just for example purpose of a long computation...
-- it helps to demonstrate function kill
local function sleep(keys, args)
    local delay = tonumber(args[1])
    local delay_microsec = delay * 1000000

    local start_time_array = redis.call('TIME')
    local start_time_microsec = tonumber(start_time_array[1] .. start_time_array[2])

    repeat
        local now_array = redis.call('TIME')
        local now_microsec = tonumber(now_array[1] .. now_array[2])
    until now_microsec - start_time_microsec > delay_microsec

    return delay
end

redis.register_function({
    function_name = 'sleep',
    callback = sleep,
    description = 'Sleep N seconds: sleep 0 N'
})

