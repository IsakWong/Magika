
function ToStr(id)
    return ('>I4'):pack(id)
end

function ToID(str)
    return ('>I4'):unpack(str)
end

function math.clamp(v, minValue, maxValue)  
    if v < minValue then
        return minValue
    end
    if( v > maxValue) then
        return maxValue
    end
    return v 
end

---@generic T 
---@param type T
---@return T
function fromUd(type,ud)
    return type:fromUd(ud)
end


return Utils
