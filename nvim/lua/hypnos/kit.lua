#!/usr/bin/env lua

function _G.split(str,div) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

function _G.tprint(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

function _G.osExec(cmd)
    local handle = assert(io.popen(cmd))
    local result = handle:read("*a")
    handle:close()
    return result
end

function _G.Reload(pack)
    package.loaded['hypnos/'..pack] = nil
    require('hypnos/'..pack)
end

-- nvim_get_var throw an error if the var doesn't exists...
function _G.get_var(el, var, default, func)
  local s, v = pcall(function()
    return func(el,var)
  end)
  if s then return v else return default end
end

function _G.starts_with(str, start)
	return str:sub(1, #start) == start
end
