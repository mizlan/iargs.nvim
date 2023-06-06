local M = {}

function M.err(msg, flag)
  if flag then
    vim.api.nvim_echo({{msg, 'Error'}}, true, {})
  end
end
local err = M.err

function M.tbl_reverse(tbl)
  for i=1, math.floor(#tbl / 2) do
    tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
  end
  return tbl
end

function M.tbl_pack(...)
  local t = {...}
  t.n = #t
  return t
end

function M.compare_position(a, b)
  if a[1] == b[1] then
    return a[2] <= b[2]
  else
    return a[1] <= b[1]
  end
end

function M.within(a, b, c)
  if #b == 4 then
    local b1 = { b[1], b[2] }
    local b2 = { b[3], b[4] }
    return M.compare_position(a, b1) and M.compare_position(b2, c)
  else
    return M.compare_position(a, b) and M.compare_position(b, c)
  end
end

local feedkeys = vim.api.nvim_feedkeys
local termcodes = vim.api.nvim_replace_termcodes
local function t(k) return termcodes(k, true, true, true) end
local esc = t('<esc>')
function M.get_cursor_range(winid)
  if vim.api.nvim_get_mode().mode:lower() == 'v' then
    feedkeys(esc, 'ix', false)
    local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
    local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))
    return { start_row - 1, start_col, end_row - 1, end_col }
  else
    local cursor = vim.api.nvim_win_get_cursor(winid)
    return { cursor[1] - 1, cursor[2] }
  end
end

-- pos is in form {r, c}
function M.node_contains_pos(node, pos)
  local sr, sc, er, ec = node:range()
  local s = {sr, sc}
  local e = {er, ec}
  return M.within(s, pos, e)
end
function M.node_contains_range(node, pos1, pos2)
  return M.node_contains_pos(node, pos1) and M.node_contains_pos(node, pos2)
end

function M.nodes_containing_pos(nodes, pos)
  local idxs = {}
  for i, node in ipairs(nodes) do
    if M.node_contains_pos(node, pos) then
      table.insert(idxs, i)
    end
  end
  return idxs
end

function M.has_siblings(node)
  return node:next_named_sibling() ~= nil or node:prev_named_sibling() ~= nil
end

function M.getchar_handler()
  local ok, key = pcall(vim.fn.getchar)
  if not ok then return nil end
  if type(key) == 'number' then
    local key_str = vim.fn.nr2char(key)
    return key_str
  end
  return nil
end

function M.node_is_range(node, range)
  local a, b, c, d = node:range()
  return a == range[1] and b == range[2] and c == range[3] and d == range[4]
end



return M
