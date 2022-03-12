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
