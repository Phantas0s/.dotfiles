-- Source: https://github.com/jhchabran/nvim-config/blob/main/lua/jh/utils.lua#L47-L86

dump_which_key_markdown = function(opts)
  local out = {}

  local indent = function(level)
    local str = ""
    for i=0,level,1 do
      str = str .. "  "
    end
    return str
  end

  local dump = function(key, label, level)
    return indent(level) .. "- `" .. key .. "`: " .. label
  end

  local fn
  fn = function(node, level)
    for k, v in pairs(node) do
      if v.name ~= nil then
        local key = k
        table.insert(out, dump(k, "**" .. v.name .. "**", level))
        fn(v, level+1)
      else
        if k ~= "name" then
          table.insert(out, dump(k, v[2], level))
        end
      end
    end
  end

  fn(opts, 0)

  local res = ""
  for i, line in ipairs(out) do
    res = res .. line .. "\n"
  end

  -- Put in the OS clipboard the result
  vim.fn.setreg('+', res)
end

return dump_which_key_markdown
