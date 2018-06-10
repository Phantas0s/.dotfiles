#! /usr/bin/env lua

-- Dorai Sitaram
-- Last modified 2017-12-10

-- Find if this file is being run within Neovim Lua.

local running_in_neovim = (vim and type(vim) == 'table' and
                           vim.api and type(vim.api) == 'table' and
                           vim.api.nvim_eval and type(vim.api.nvim_eval) == 'function')

-- If running_in_neovim, this file defines a GetScmIndent() that can be used
-- for 'indentexpr' to automatically indent Scheme/Lisp code in a Neovim
-- buffer. If not, it is a script that takes lines of Lisp or Scheme code from
-- its stdin and produces an indented version thereof on its stdout.

function file_exists(f)
  local h = io.open(f)
  if h ~= nil then
    io.close(h); return true
  else
    return false
  end
end

local lwfile = os.getenv('HOME') .. '/.lispwords.lua'

local lispwords = file_exists(lwfile) and dofile(lwfile) or {}

function split_string(s, c)
  local r = {}
  if s then
    local start = 1
    local i
    while true do
      i = string.find(s, c, start, true)
      if not i then
        table.insert(r, string.sub(s, start, -1))
        break
      end
      table.insert(r, string.sub(s, start, i-1))
      start = i+1
    end
  end
  return r
end

if running_in_neovim then
  do
    local vimlw = split_string(vim.api.nvim_get_option('lw'), ',')
    for _,w in ipairs(vimlw) do
      if not lispwords[w] then
        lispwords[w] = 0
      end
    end
  end
end

function string_trim_blanks(s)
  return string.gsub(string.gsub(s, '^%s+', ''), '%s+$', '')
end

function is_literal_token(s)
  return string.find(s, '^[0-9#]')
end

function get_lisp_indent_number(s)
  s = string.lower(s)
  local n = lispwords[s]
  if n then return n
  elseif string.find(s, '^def') then return 0
  else return -1
  end
end

function past_next_atom(s, i, n)
  -- gives the index in s that's just past the atom starting at s[i].
  -- Result can't be more than n+1.
  -- If no atom found, result is i itself.
  while true do
    if i > n then return n+1 end
    local c = string.sub(s, i, i)
    if c == '\\' then
      i = i+2
    elseif string.find(c, '[][ \t()\'"`,;]') then
      return i
    else
      i = i+1
    end
  end
end

function calc_subindent(s, i, n)
  -- we're looking for a keyword directly after an lparen in s[i-1]
  local j = past_next_atom(s, i, n)
  -- j would be just after that keyword
  -- it's possible no keyword found, in which case j == i
  local delta_indent = 0
  local lisp_indent_num = -1
  if j == i then
    do end
  else
    local w = string.sub(s, i, j-1) -- the keyword itself
    local c2
    if i > 2 then
      local i2 = i-2; c2 = string.sub(s, i2, i2)
      -- c2 is the char before the lparen
    end
    if c2 == "'" or c2 == '`' or is_literal_token(w) then
      do end
    else
      lisp_indent_num = get_lisp_indent_number(w)
      if lisp_indent_num == -2 then
        do end
      elseif lisp_indent_num == -1 then
        if j < n then
          delta_indent = j - i + 1
        else
          delta_indent = 1
        end
      else
        delta_indent = 1
      end
    end
  end
  return delta_indent, lisp_indent_num, j
end

function num_leading_spaces(s)
  local n = #s
  local i = 1
  local j = 0
  while true do
    if i > n then return 0 end
    local c = string.sub(s, i, i)
    if c == ' ' then
      i = i+1; j = j+1
    elseif c == '\t' then
      i = i+1; j = j+8
    else
      return j
    end
  end
end

function do_indent(curr_buf, pnum, lnum)
  local default_left_i = -1
  local left_i = 0
  local paren_stack = {}
  local is_inside_string = false
  local cnum = pnum
  while true do
    local curr_line
    if running_in_neovim then
      if cnum > lnum then break end
      curr_line = vim.api.nvim_buf_get_lines(curr_buf, cnum, cnum+1, 1)[1]
    else
      curr_line = io.read()
      if not curr_line then break end
    end
    local leading_spaces = num_leading_spaces(curr_line)
    local curr_left_i
    --
    if is_inside_string then
      curr_left_i = leading_spaces
    elseif #paren_stack == 0 then
      if left_i == 0 then
        if default_left_i == -1 then
          default_left_i = leading_spaces
        end
        left_i = default_left_i
      end
      curr_left_i = left_i
    else
      -- current line is inside a form.
      curr_left_i = paren_stack[1].spaces_before
      if paren_stack[1].num_finished_subforms < paren_stack[1].lisp_indent_num then
        --paren_stack[1].num_finished_subforms = paren_stack[1].num_finished_subforms + 1
        curr_left_i = curr_left_i + 2
      end
    end
    if running_in_neovim and cnum == lnum then
      return curr_left_i
    end
    curr_line = string_trim_blanks(curr_line)
    if not running_in_neovim then
      io.write(string.rep(' ', curr_left_i), curr_line, '\n')
    end
    --
    local n = #curr_line
    local is_escape = false
    local is_token_interstice = false
    local function incr_finished_subforms()
      if not is_token_interstice then
        if #paren_stack > 0 then
          paren_stack[1].num_finished_subforms = paren_stack[1].num_finished_subforms + 1
        end
        is_token_interstice = true
      end
    end
    local i = 1
    while i <= n do
      local c = string.sub(curr_line, i, i)
      if is_escape then
        is_escape = false; i = i+1
      elseif c == '\\' then
        is_token_interstice = false
        is_escape = true; i = i+1
      elseif is_inside_string then
        if c == '"' then
          is_inside_string = false
          incr_finished_subforms()
        end
        i = i+1
      elseif c == ';' then
        incr_finished_subforms()
        break
      elseif c == '"' then
        incr_finished_subforms()
        is_inside_string = true; i = i+1
      elseif c == ' ' or c == '\t' then
        incr_finished_subforms()
        i = i+1
      elseif c == '(' or c == '[' then
        incr_finished_subforms()
        local delta_indent, lisp_indent_num, j = calc_subindent(curr_line, i+1, n)
        table.insert(paren_stack, 1, {
          spaces_before = curr_left_i + i + delta_indent,
          lisp_indent_num = lisp_indent_num,
          num_finished_subforms = -1
        })
        is_token_interstice = true
        i = i+1
        if j > i then
          i = j
          is_token_interstice = false
        end
      elseif string.find(c, '[])]') then
        if #paren_stack > 0 then
          table.remove(paren_stack, 1)
          is_token_interstice = false
          if #paren_stack == 0 then
            left_i = 0
            is_token_interstice = true
          else
            incr_finished_subforms()
          end
        end
        i = i+1
      else
        is_token_interstice = false; i = i+1
      end
    end
    incr_finished_subforms()
    cnum = cnum+1
  end
end

local neoscmindent = {}

if running_in_neovim then
  neoscmindent.GetScmIndent = function(lnum1)
    local lnum = lnum1 - 1 -- convert to 0-based line number
    local curr_buf = vim.api.nvim_get_current_buf()
    --
    -- pnum is determined by going up until you cross two contiguous blank
    -- regions (if possible), then finding the first nonblank after that.
    --
    local pnum = lnum - 1
    if pnum < 0 then pnum = 0 end
    local one_blank_seen = false
    local currently_blank = false
    while pnum > 0 do
      local pstr = vim.api.nvim_buf_get_lines(curr_buf, pnum, pnum+1, 1)[1]
      if pstr:match("%s*$") then
        if currently_blank then
          do end
        elseif one_blank_seen then
          pnum = pnum + 1
          break
        else
          currently_blank = true
          one_blank_seen = true
        end
      else
        currently_blank = false
      end
      pnum = pnum - 1
    end
    --
    return do_indent(curr_buf, pnum, lnum)
  end
end

if running_in_neovim then
  return neoscmindent
else
  do_indent(false, 1, 1)
end
