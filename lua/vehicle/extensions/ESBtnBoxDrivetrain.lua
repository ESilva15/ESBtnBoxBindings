local M = {}

----------------------------------------------------------------------------------------------------
-- Range Box
----------------------------------------------------------------------------------------------------

local rangeMode4hi = "4hi"
local rangeMode4lo = "4lo"
local rangeMode2hi = "2hi"
local curRangeMode = rangeMode2hi

local function changeMode(tfc, mode)
  if curRangeMode == mode then
    mode = rangeMode2hi
  end

  tfc.setDriveMode(mode)
  curRangeMode = mode
end

local function toggleHighFour()
  -- local transferCase = controller.getControllersByType('transfercaseControl')
  local transferCase = controller.getController('transfercaseControl')
  if transferCase == nil then
    return
  end

  changeMode(transferCase, rangeMode4hi)
end

local function toggleLowFour()
  -- local transferCase = controller.getControllersByType('transfercaseControl')
  local transferCase = controller.getController('transfercaseControl')

  if transferCase == nil then
    return
  end

  changeMode(transferCase, rangeMode4lo)
end

M.toggleHighFour = toggleHighFour
M.toggleLowFour = toggleLowFour

return M