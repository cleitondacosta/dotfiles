-- Smart Splits (thanks https://github.com/mrjones2014/smart-splits.nvim)

local Direction = { left = 'left', right = 'right', up = 'up', down = 'down' }
local WinPosition = { first = 0, middle = 1, last = 2 }
local resizeApi = {}

local function win_position(direction)
  if direction == Direction.left or direction == Direction.right then
    if vim.fn.winnr() == vim.fn.winnr('h') then return WinPosition.first end
    if vim.fn.winnr() == vim.fn.winnr('l') then return WinPosition.last end
    return WinPosition.middle
  end

  if vim.fn.winnr() == vim.fn.winnr('k') then return WinPosition.first end
  if vim.fn.winnr() == vim.fn.winnr('j') then return WinPosition.last end

  return WinPosition.middle
end

local function resize(direction, amount)
  local isHorizontalResize = direction == Direction.up or direction == Direction.down
  local resizeOperation
  local orientation = ''
  local current_pos = win_position(direction)

  if isHorizontalResize then
      if current_pos == WinPosition.first or current_pos == WinPosition.middle then
          resizeOperation = direction == Direction.up and '-' or '+'
      else
          resizeOperation = direction == Direction.down and '-' or '+'
      end
  else
      orientation = 'vertical '

      if current_pos == WinPosition.first or current_pos == WinPosition.middle then
          resizeOperation = direction == Direction.right and '+' or '-'
      else
          resizeOperation = direction == Direction.left and '+' or '-'
      end
  end

  local resizeCommand = string.format('%sresize %s%s', orientation, resizeOperation, amount)
  vim.cmd(resizeCommand)
end

vim.tbl_map(
    function(direction)
        resizeApi[string.format('resize_%s', direction)] = function()
            local amount = (
                (direction == Direction.left or direction == Direction.right)
                and 6
                or 2
            )

            resize(direction, amount)
        end
    end,
    {
        Direction.left,
        Direction.right,
        Direction.up,
        Direction.down,
    }
)

return resizeApi
