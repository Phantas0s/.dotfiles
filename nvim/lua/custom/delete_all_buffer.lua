#!/usr/bin/env lua

local function split(str,div) -- credit: http://richard.warburton.it
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

local function buflist()
    bufnames = vim.api.nvim_exec('silent ls', true)
    local list, bufs = {}, vim.fn.split(bufnames, "\n")
    for k, v in pairs(bufs) do
        local buf = split(v, '"')
        table.insert(list, buf[2])
        print(vim.inspect(list))
    end

    return list
end
buflist()

return {
    buffer_list = buflist
}
