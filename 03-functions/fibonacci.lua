#!lua name=jlg

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

redis.register_function('fibonacci', fibonacci)

