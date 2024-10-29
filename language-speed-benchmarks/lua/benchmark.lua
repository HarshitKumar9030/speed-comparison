function is_prime(n)
    for i = 2, math.sqrt(n) do
        if n % i == 0 then
            return false
        end
    end
    return true
end

local start = os.clock()
local count = 0
for i = 2, 100000 do
    if is_prime(i) then
        count = count + 1
    end
end
local end_time = os.clock()
print("Lua:", end_time - start, "seconds")
